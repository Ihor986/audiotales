import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppService {
  ShareAppService._();
  static final ShareAppService instance = ShareAppService._();
  final Share shareService = Share();

  Future<void> shareFiles(BuildContext context, List<String> paths) async {
    final box = context.findRenderObject() as RenderBox?;
    if (paths.isNotEmpty) {
      await Share.shareFiles(paths,
          text: 'text',
          subject: 'subject',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share('text',
          subject: 'subject',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  // Future<void> onShareWithResult(
  //     BuildContext context, List<String> imagePaths) async {
  //   print('step1');
  //   final box = context.findRenderObject() as RenderBox?;
  //   ShareResult result;
  //   if (imagePaths.isNotEmpty) {
  //     result = await Share.shareFilesWithResult(imagePaths,
  //         text: 'text',
  //         subject: 'subject',
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   } else {
  //     result = await Share.shareWithResult('text',
  //         subject: 'subject',
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   }
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text("Share result: ${result.status}"),
  //   ));
  // }
}
