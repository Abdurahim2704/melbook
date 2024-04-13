import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          builder: (context) => UpdateProfile(),
                        ));
                  },
                  icon: Icon(Icons.edit)),
            )
          ],
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ListView(
            children: [
              const SizedBox(height: 20),
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
                            color: current == 0 ? Colors.white : Colors.black),
                      )),
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
                            color: current == 1 ? Colors.white : Colors.black),
                      )),
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
                    state.user!.userName,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  // trailing: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Text(trailing[i],
                  //         style: TextStyle(
                  //             fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  //     Text(trailingSub[i], style: TextStyle(fontSize: 14.sp)),
                  //   ],
                  // ),
                ),
                ListTile(
                  shape: Border(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(0.3), width: 1)),
                  title: Text(
                    titles[1],
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    state.user!.name,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(trailing[1],
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      Text(state.user!.surname,
                          style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ),
                ListTile(
                  shape: Border(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(0.3), width: 1)),
                  title: Text(
                    titles[2],
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    state.user!.phoneNumber,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(trailing[2],
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      Text(trailingSub[2], style: TextStyle(fontSize: 14.sp)),
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
                          )
                      ]),
                )
            ],
          );
        },
      ),
    );
  }
}
