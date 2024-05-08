import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/home/data/service/last_read.dart';
import 'package:melbook/features/home/presentation/views/book_tile.dart';
import 'package:melbook/locator.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

import 'bloc/book/book_bloc.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  void initState() {
    super.initState();
    print(getIt<AuthRepository>().token);
    context.read<BookBloc>().add(GetAllBooks());
    context.read<AuthBloc>().stream.listen((event) {
      if (event.message != null && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
    });
    getIt<SharedPreferenceService>().getLastPage().then(
      (value) {
        print("Index: $value");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<BookBloc>().add(GetAllBooks());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, h * 0.09),
          child: CustomAppBar(
            displayText:
                "Xush kelibsiz ${getIt<AuthRepository>().user?.userName ?? ""}",
          ),
        ),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            return state is BookLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.023),
                        ListView.separated(
                          itemBuilder: (context, index) {
                            final book = state.books[index];
                            return BookTile(
                              book: book,
                              imagePath: state.books[index].photoUrl,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 15);
                          },
                          itemCount: state.books.length,
                          shrinkWrap: true,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
