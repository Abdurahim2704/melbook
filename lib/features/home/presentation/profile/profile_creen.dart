import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/auth/presentation/sign_up.dart';
import 'package:melbook/features/home/presentation/bloc/book/book_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/features/home/presentation/profile/update_profile.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int current = 0;
  List<String> titles = ["Foydalanuvchi nomi", "Ism", "Telefon raqam"];
  List<String> trailing = ["", "Familiya", "To'lov turi"];
  List<String> trailingSub = ["", "Ismoilov", "Click"];

  void logOut() {
    context
        .read<AuthBloc>()
        .add(LogOut(localBooks: context.read<LocalStorageBloc>().state.books));
    context.read<AuthBloc>().stream.listen((event) {
      if (event is LogOutSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUp(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: Stack(
          children: [
            const CustomAppBar(
              displayText: "Profile",
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateProfile(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  size: 26,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        contentPadding: const EdgeInsets.all(60),
                        title: const Text(
                          "Tizimdan chiqishni xohlaysizmi ?",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Yo'q",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          TextButton(
                            onPressed: logOut,
                            child: const Text(
                              "Ha",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ListView(
            children: [
              SizedBox(height: h * 0.02),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          current == 0 ? Colors.black : Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.12,
                        vertical: h * 0.005,
                      ),
                    ),
                    onPressed: () {
                      current = 0;
                      setState(() {});
                    },
                    child: Text(
                      "Asosiy",
                      style: TextStyle(
                        color: current == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          current == 1 ? Colors.black : Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.12,
                        vertical: h * 0.005,
                      ),
                    ),
                    onPressed: () {
                      current = 1;
                      setState(() {});
                    },
                    child: Text(
                      "To'lov",
                      style: TextStyle(
                        color: current == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (current == 0) ...[
                ListTile(
                  shape: Border(
                    top: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  title: Text(
                    titles[0],
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    state.user?.userName ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            titles[1],
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.user?.name ?? "Unknown",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            trailing[1],
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.user?.name ?? "Unknown",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            titles[2],
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.user?.phoneNumber ?? "Unknown",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            trailing[2],
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Click",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
              if (current == 1)
                ListTile(
                  shape: Border(
                    top: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  title: const Text(
                    "To'lov turi",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Click",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              if (current == 1)
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "To'lovlar",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<BookBloc, BookState>(
                        builder: (context, state) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.books
                                .where((element) => element.bought)
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              final book = state.books
                                  .where((element) => element.bought)
                                  .toList()[index];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    book.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      height: 2,
                                    ),
                                  ),
                                  Text(
                                    "${book.price} so'm",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
