import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

import '../backend/book.dart';
import '../backend/error_handler.dart';
import 'components/build_frog.dart';
import 'elements/widgets/loader.dart';

//Typing
typedef AsyncBook = AsyncSnapshot<Book?>;

///
typedef BookWaitingBuilder = Widget Function(BuildContext context, AsyncBook);

//WHEN YOU HAVE OTHER BOOKS, change this.
Future<Book?>? _bookFuture;

class BookWaiter extends StatelessWidget {
  ///
  ///   Must be under a Scaffold
  ///   To avoid making the user wait for the drawer button.
  ///   The sub-objects need to be provided a scaffold.
  ///
  final Widget child;
  const BookWaiter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    //The BookLoader was a bypass for the futuristic book object.
    //Must be under a scaffold
    assert(Scaffold.maybeOf(context) != null);
    //Check if Book is already present
    Book? existing = Book.maybeOf(context);
    //TODO: See if this is causing unecessary cpu
    if (existing != null) {
      assert(false, 'Nested BookWaiters');
      assert(_bookFuture != null);
      //In theory, this can't not be set
      _bookFuture ??= existing as Future<Book?>?;
      return child;
    }
    //Get book if null
    _bookFuture ??= BookLoader.instance.load();

    return FutureBuilder<Book?>(
        future: _bookFuture!, builder: subScaffoldBuilder);
  }

  Widget subScaffoldBuilder(BuildContext context, AsyncBook snapshot) {
    if (snapshot.hasData) {
      Book? bk = snapshot.data;
      if (bk == null) {
        return ErrorList.stringBox(context,
            text: "They turned my book into a null!");
      } else {
        return BookProvider(book: bk, child: child);
      }
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .element(context);
    } else {
      return const Center(
          child: TriWizardLoader(
        message: 'Getting book',
      ));
    }
  }
}

class CowboyBookBuilder extends StatelessWidget {
  ///   Provides its own Scaffold
  ///   I CBA making a CowboyBookWaiter object that keeps the scaffolds consistent.
  ///   Beebop

  final WidgetBuilder doneBuilder;
  final McScaffold Function(
      BuildContext context, Widget child, AsyncBook bookData)? scaffoldBuilder;

  const CowboyBookBuilder(
      {super.key, required this.doneBuilder, this.scaffoldBuilder});

  Widget _standardScaffoldBuilder(
      BuildContext context, Widget child, AsyncBook bookData) {
    return McScaffold(source: null, child: child);
  }

  Widget scaffold(BuildContext context, Widget child, AsyncBook bookData) {
    var builder = scaffoldBuilder ?? _standardScaffoldBuilder;
    return builder(context, child, bookData);
  }

  AsyncBook doneSnapshot(Book book) {
    return AsyncBook.withData(ConnectionState.done, book);
  }

  @override
  Widget build(BuildContext context) {
    assert(Scaffold.maybeOf(context) == null, 'No scaffold stacking!');
    //Check if Book is already present
    //TODO: See if this is causing unecessary cpu
    Book? book = Book.maybeOf(context);
    if (book != null) {
      assert(false, 'No bookProvider stacking!');
      //In theory, this can't not be set
      _bookFuture ??= book as Future<Book?>?;
      return scaffold(context, doneBuilder(context), doneSnapshot(book));
    }
    //Get book if null
    _bookFuture ??= BookLoader.instance.load();

    return FutureBuilder<Book?>(
        future: _bookFuture!, builder: aboveScaffoldBuilder);
  }

  Widget aboveScaffoldBuilder(BuildContext context, AsyncBook snapshot) {
    assert(Scaffold.maybeOf(context) == null, 'No scaffold stacking!');
    Widget child;
    if (snapshot.connectionState == ConnectionState.done) {
      Book? bk = snapshot.data;
      if (bk == null) {
        child = ErrorList.stringBox(context,
            text: "They turned my book into a null!");
      } else {
        child = BookProvider(book: bk, child: BuildFrog(builder: doneBuilder));
      }
    } else if (snapshot.hasError) {
      return ErrorList.logError(snapshot.error!, snapshot.stackTrace)
          .element(context);
    } else {
      child = const Center(
          child: TriWizardLoader(
        message: 'Getting book',
      ));
    }
    //Wrap in scaffold for precious user
    return scaffold(context, child, snapshot);
  }
}

class BookBuilder extends StatelessWidget {
  /// Uses the standard Book object, which does still have to be loaded.
  ///  This one doesn't have to be under a Scaffold.
  ///
  ///    Your builder, however, must provide a scaffold.

  final BookWaitingBuilder builder;
  const BookBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    //Get book if null
    _bookFuture ??= BookLoader.instance.load();

    //Check if Book is already present

    //TODO: See if this is uneccesary CPU load
    if (Book.maybeOf(context) != null) {
      assert(false);
      return builder(context,
          AsyncSnapshot.withData(ConnectionState.done, Book.of(context)));
    }
    return FutureBuilder(future: _bookFuture, builder: builder);
  }
}

//TODO: Add one that's a separated builder for Scaffold & Widget
