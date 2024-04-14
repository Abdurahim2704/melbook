import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/auth/presentation/sign_up.dart';
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
    context.read<AuthBloc>().add(LogOut());
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90.h),
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
                  icon: Icon(
                    Icons.edit,
                    size: 18.sp,
                  )),
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
                        title: Text(
                          "Tizimdan chiqishni xohlaysizmi ?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Yo'q"),
                          ),
                          SizedBox(width: 20.w),
                          TextButton(
                            onPressed: logOut,
                            child: const Text("Ha"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.logout,
                  size: 18.sp,
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
              SizedBox(height: 20.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 20.w),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            current == 0 ? Colors.black : Colors.transparent),
                    onPressed: () {
                      current = 0;
                      setState(() {});
                    },
                    child: Text(
                      "Asosiy",
                      style: TextStyle(
                        color: current == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            current == 1 ? Colors.black : Colors.transparent),
                    onPressed: () {
                      current = 1;
                      setState(() {});
                    },
                    child: Text(
                      "To'lov",
                      style: TextStyle(
                        color: current == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
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
                          color: Colors.grey.withOpacity(0.3), width: 1)),
                  title: Text(
                    titles[0],
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    state.user?.userName ?? "Unknown",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.withOpacity(0.3), width: 1)),
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
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            state.user?.name ?? "Unknown",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(trailing[1],
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            state.user?.name ?? "Unknown",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.withOpacity(0.3), width: 1)),
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
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            state.user?.phoneNumber ?? "Unknown",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            trailing[2],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Click",
                            style: TextStyle(fontSize: 14.sp),
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
                        color: Colors.grey.withOpacity(0.3), width: 1),
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3), width: 1),
                  ),
                  title: Text(
                    "To'lov turi",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Click",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              if (current == 1)
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "To'lovlar",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      for (int i = 0; i < 3; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Arab tili",
                              style: TextStyle(fontSize: 14.sp, height: 2),
                            ),
                            Text(
                              "12/02/2003",
                              style: TextStyle(fontSize: 14.sp, height: 2),
                            ),
                            Text(
                              "580 000",
                              style: TextStyle(fontSize: 14.sp, height: 2),
                            ),
                          ],
                        ),
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
