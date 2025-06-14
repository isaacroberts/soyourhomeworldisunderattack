import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soyourhomeworld/backend/error_handler.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';
import 'package:soyourhomeworld/frontend/elements/widgets/loader.dart';

import '../../backend/book.dart';
import '../../backend/library.dart';
import '../styles.dart';

class BookSelectorPage extends StatefulWidget {
  const BookSelectorPage({super.key});

  @override
  State<BookSelectorPage> createState() => _BookSelectorPageState();
}

class _BookSelectorPageState extends State<BookSelectorPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return McScaffold(
        source: 'library',
        child: FutureBuilder(
            future: Library.getInstance().availableBooks(), builder: builder));
  }

  Widget builder(BuildContext context, AsyncSnapshot<List<BookLoader>> data) {
    if (data.hasError) {
      ErrorList.logError(data.error!, data.stackTrace);
    }
    if (data.hasData) {
      if (data.data != null) {
        List<BookLoader> books = data.data!;
        return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            children: [
              for (BookLoader book in books) BookNook(bookLoader: book)
            ]);
      } else {
        return ErrorList.instance.page(context);
      }
    }

    return const TriWizardLoader();
  }
}

class BookNook extends StatelessWidget {
  final BookLoader bookLoader;
  const BookNook({super.key, required this.bookLoader});

  void onBookClicked(BuildContext context) {
    GoRouter.of(context).go('/');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        height: 200,
        child: FutureBuilder(future: bookLoader.load(), builder: bookInfo));
  }

  Widget bookInfo(BuildContext context, AsyncSnapshot<Book?> data) {
    if (data.hasError) {
      ErrorList.logError(data.error!, data.stackTrace);
    }
    if (data.hasData) {
      Book? book = data.data;
      if (book == null) {
        return failedBook(context);
      } else {
        return successfulBook(context, book);
      }
    } else {
      return loadingBook(context);
    }
  }

  Widget failedBook(BuildContext context) {
    return Card(
        color: const Color(0xff444444),
        child: Center(
          child: Text(bookLoader.id),
        ));
  }

  Widget loadingBook(BuildContext context) {
    return Card(
        color: bookLoader.color,
        child: Column(
          children: [
            Text(bookLoader.id),
            const CircularProgressIndicator(),
          ],
        ));
  }

  Widget successfulBook(BuildContext context, Book book) {
    return Card(
        color: book.color,
        child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () => onBookClicked(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(book.title),
                const Flexible(child: SizedBox.shrink()),
                Text(
                  book.byline,
                  style: bodyFont.copyWith(fontSize: 8),
                ),
              ],
            )));
  }
}
