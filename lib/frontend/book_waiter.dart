import 'package:flutter/material.dart';

import '../backend/book.dart';
import '../backend/error_handler.dart';
import 'elements/widgets/loader.dart';

class BookWaiter extends StatelessWidget {
  /*
  Must be under a Scaffold
   */
  final Future<Book?> book;
  final Widget child;
  const BookWaiter({super.key, required this.book, required this.child});

  @override
  Widget build(BuildContext context) {
    //Must be under a scaffold
    assert(Scaffold.maybeOf(context) != null);
    //Check if Book is already present
    if (Book.maybeOf(context) != null) {
      return child;
    }
    Future<Book?> book = this.book;
    return FutureBuilder(
        future: book,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Book? bk = snapshot.data;
            if (bk == null) {
              return const ErrorBox(text: "They turned my book into a null!");
            } else {
              return BookProvider(book: bk, child: child);
            }
          } else if (snapshot.hasError) {
            ErrorList.logError(snapshot.error!, snapshot.stackTrace);
            return ExceptionBox.fromException(
                snapshot.error ?? '?', snapshot.stackTrace);
          } else {
            return const Center(
                child: TriWizardLoader(
              text: 'Getting book',
            ));
          }
        });
  }
}

class StdBookWaiter extends StatelessWidget {
  final Widget child;
  const StdBookWaiter({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    //Check if book is already present
    //This in theory allows you to open different books
    if (Book.maybeOf(context) != null) {
      return child;
    }
    return BookWaiter(book: BookLoader.instance.load(), child: child);
  }
}
