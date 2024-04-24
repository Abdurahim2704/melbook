import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/features/home/presentation/views/online_list_tile.dart';

class ContainerAudiosListening extends StatefulWidget {
  final BookData bookData;

  const ContainerAudiosListening({super.key, required this.bookData});

  @override
  State<ContainerAudiosListening> createState() =>
      _ContainerAudiosListeningState();
}

class _ContainerAudiosListeningState extends State<ContainerAudiosListening> {
  @override
  void initState() {
    super.initState();
    context.read<LocalStorageBloc>().stream.listen((event) {
      if (event is DownloadSuccess) {}
    });
  }

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalStorageBloc, LocalStorageState>(
        builder: (context, state) {
      return ListView.builder(
        padding: EdgeInsets.only(bottom: 10.h, left: 12.w, right: 12.w),
        itemCount: widget.bookData.audios?.length,
        itemBuilder: (context, index) {
          final currentAudio = widget.bookData.audios?[index];
          return OnlineListTile(
            bookData: widget.bookData,
            currentAudio: currentAudio!,
            index: index,
          );
        },
      );
    });
  }
}
