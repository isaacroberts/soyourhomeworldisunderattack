import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';
import 'package:soyourhomeworld/frontend/pages/scrollers/slivers/load_sliver.dart';
import 'package:soyourhomeworld/frontend/view_settings.dart';

import '../../../backend/chapter.dart';
import '../../../backend/error_handler.dart';
import '../../elements/holders/holder_base.dart';

class ReaderBuilder extends StatefulWidget {
  /// Builds & shows elements, as loading fonts
  ///
  ///
  /// TODO: This is causing jumps, when scrolling up.
  /// I think the previous chapter is getting reloaded, and has a smaller height
  final Chapter chapter;

  final Widget Function(BuildContext, Holder, bool) itemBuilder;
  final List<Widget> leadItems;
  final List<Widget> endItems;
  final Widget? waitingWidget;
  final bool useSliverProtocol;

  const ReaderBuilder(
      {required super.key,
      required this.chapter,
      required this.itemBuilder,
      required this.useSliverProtocol,
      this.leadItems = const [],
      this.endItems = const [],
      this.waitingWidget});

  @override
  State<ReaderBuilder> createState() => ReaderBuilderState();
}

class ReaderBuilderState extends State<ReaderBuilder> {
  //Displays only N holders
  int itemsToDisplay = 0;
  bool _showFonts = true;
//TODO: PUt back
//   bool get showFonts => _showFonts && ViewSettings.instance.showFonts;
  bool get showFonts => ViewSettings.instance.showFonts;
  bool get useSliverProtocol => widget.useSliverProtocol;

  @override
  void initState() {
    super.initState();
    // dev.log("Reader init ${chapter.varName}");
    widget.chapter.addListener(_chapterUpdated);
    loadAndDisplayThread();
  }

  @override
  void didChangeDependencies() {
    // dev.log("Reader changedDep ${chapter.varName}");

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get doneLoading => itemsToDisplay >= maxLength;

  int get maxLength => widget.chapter.length;

  Chapter get chapter => widget.chapter;
  int get chapterNo => widget.chapter.id;

  String get _debugId => widget.chapter.debugId;

  void loadAndDisplayThread() async {
    if (itemsToDisplay < maxLength) {
      int itemsToDisplay = this.itemsToDisplay;
      // dev.log("(Font) loadthread (chp=$_debugId) items=$itemsToDisplay");
      //Not loading any fonts
      if (!mounted) {
        return;
      }
      if (!showFonts) {
        dev.log('(Font) fallbacks (chp=$_debugId)');
        //Set to maximum
        if (itemsToDisplay < maxLength) {
          setState(() {
            this.itemsToDisplay = maxLength;
          });
        }
        //Fallbacks//
      } else {
        //Iterate through fonts
        for (int n = itemsToDisplay; n < maxLength; ++n) {
          //Ensures itemsToDisplay hasn't been updated outside the funtion
          if (!mounted) {
            dev.log("Dispose unmounted font loader (chp=$_debugId)");

            return;
          }
          if (n >= this.itemsToDisplay) {
            //If waiting to load font
            Holder h = widget.chapter.lines[n];
            if (!h.isLoaded()) {
              // dev.log("(Font) Needs load $n/$maxLength (chp=$_debugId)");
              //First update the sclinesreen to the current amount.
              itemsToDisplay = n;
              if (itemsToDisplay < this.itemsToDisplay) {
                setState(() {
                  dev.log(
                      "(Font) Catchup itemsToDisplay $itemsToDisplay->${this.itemsToDisplay}/$maxLength items (chp=$_debugId)");
                  this.itemsToDisplay = itemsToDisplay;
                });
              }
              //Try - catch loading errors
              try {
                //Now load the font
                // dev.log("(Font) Loading $n (chp=$_debugId)");
                await h.load();
              } catch (exception, stackTrace) {
                //On loading error, use Fallbacks
                if (!mounted) {
                  return;
                }
                setState(() {
                  _showFonts = false;
                  this.itemsToDisplay = maxLength;
                });
                dev.log("(Font) Using fallbacks (chp ${chapter.varName})");

                dev.log(exception.toString(), stackTrace: stackTrace);
                ErrorList.showError(exception, stackTrace);
                return;
              }
            }
          }
        }
        //Now that we're done, update to maximum
        if (this.itemsToDisplay < maxLength) {
          setState(() {
            // dev.log('(Font) Font loading finished- set to max (chp=$_debugId)');
            this.itemsToDisplay = maxLength;
          });
        }
      }
    }
  }

  Holder getTextHolder(int n) {
    return chapter.lines[n];
  }

  //Handles
  void _chapterUpdated() {
    if (mounted) {
      loadAndDisplayThread();
    }
  }

  Widget endWaitingWidget(BuildContext context) {
    if (useSliverProtocol) {
      return const SliverToBoxAdapter(
          child: SizedBox(
        height: 300,
        child: Center(
            child: TriWizardLoader(
          message: 'Loading...',
        )),
      ));
    }
    return const SizedBox(
      height: 300,
      child: Center(
          child: TriWizardLoader(
        message: 'Loading...',
      )),
    );
  }

  Iterable<Widget> itemIterator(BuildContext context) sync* {
    for (Widget lead in widget.leadItems) {
      yield lead;
    }
    for (int n = 0; n < itemsToDisplay; ++n) {
      yield widget.itemBuilder(context, chapter.lines[n], showFonts);
    }
    if (doneLoading) {
      for (Widget end in widget.endItems) {
        yield end;
      }
    } else {
      yield widget.waitingWidget ?? endWaitingWidget(context);
    }
  }

  Widget? sliverBuilder(BuildContext context, int index) {
    if (index < widget.leadItems.length) {
      return widget.leadItems[index];
    }
    index -= widget.leadItems.length;
    if (index >= 0 && index < itemsToDisplay) {
      return widget.itemBuilder(context, chapter.lines[index], showFonts);
    }
    index -= chapter.lines.length;
    if (doneLoading) {
      if (index >= 0 && index < widget.endItems.length) {
        return widget.endItems[index];
      }
    } else {
      //Janky
      // if (index == 0) {
      //   return widget.waitingWidget ?? endWaitingWidget(context);
      // }
    }
    return null;
  }

  Widget unloadedBuilder(BuildContext context) {
    //Shows basic loading screen
    if (useSliverProtocol) {
      return ChapterLoadSliver(chapterTitle: chapter.displayTitle);
    }
    return const SizedBox(
      height: 400,
      child: Center(
        //Loading Icon
        child: TriWizardLoader(message: 'Loading chapter...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (!chapter.loaded) {
    //   return unloadedBuilder(context);
    // }
    if (useSliverProtocol) {
      if (!doneLoading) {
        return ChapterLoadSliver(chapterTitle: chapter.displayTitle);
      }

      return IsFallbackProvider(
          showFonts: showFonts,
          // child: ConstrainedBox(
          //     constraints:
          //         BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: SliverMainAxisGroup(
              key: Key('RdrSlvrChp${widget.chapter.id}'),
              slivers: itemIterator(context).toList(growable: false)));
    } else {
      return IsFallbackProvider(
          showFonts: showFonts,
          // child: ConstrainedBox(
          //     constraints:
          //         BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: SelectableRegion(
              selectionControls: MaterialTextSelectionControls(),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //TODO: Why a PageStorage Key?
                  key: Key('RdrBldrChp${widget.chapter.id}'),
                  children: itemIterator(context).toList(growable: false))));
    }
  }
}
