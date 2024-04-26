import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/home/presentation/views/book_tile.dart';
import 'package:melbook/locator.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Xush kelibsiz, ${getIt<AuthRepository>().user?.userName ?? ""}",
          style: TextStyle(
            fontSize: 33.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return Column(

            children: [
              // Text("Kitoblar", style: TextStyle(fontSize: 33.sp, fontWeight: FontWeight.bold, color: Colors.black),),
              ListView.separated(itemBuilder: (context, index) {
                final book = state.books[index];
                return BookTile(
                  book: book,
                  imagePath: state.books[index].photoUrl,
                );
              }, separatorBuilder: (context, index) {
                return SizedBox(height: 15.h);
              }, itemCount: state.books.length, shrinkWrap: true,),
            ],
          );
        },
      ),
    );
  }
}
