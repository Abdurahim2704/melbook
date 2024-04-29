import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90.h),
        child: CustomAppBar(
          displayText:
              "Xush kelibsiz, ${getIt<AuthRepository>().user?.userName ?? ""}",
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                ListView.separated(
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return BookTile(
                      book: book,
                      imagePath: state.books[index].photoUrl,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 15.h);
                  },
                  itemCount: state.books.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
