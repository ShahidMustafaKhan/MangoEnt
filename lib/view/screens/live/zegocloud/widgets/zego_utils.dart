import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/Utils.dart';

class ZegoUtils {
  static showAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tips'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static showImage(BuildContext context, MemoryImage? imageData,
      {String? path}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (imageData == null) {
            print('[ZegoUtils][showImage] image data is null!');
            return Container();
          }

          return AlertDialog(
            actionsPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
              child: Container(
                  width: 311.0.w,
                  height: 580.0.w,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12.w)),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image(
                                image: imageData,
                                height: 450.w,
                                width: double.infinity,
                                fit:BoxFit.cover,),
                              Positioned(
                                  top: -5,
                                  right: -5,
                                  child: InkWell(
                                    onTap: ()=> QuickHelp.goBack(context),
                                    child: Container(
                                      height: 37.w,
                                      width: 37.w,
                                      child: Stack(
                                        children: [
                                          Image.asset("assets/png/userProfile/Rectangle.png"),
                                          Positioned(
                                              top: 14.w,
                                              left: 10.w,

                                              child: Image.asset("assets/png/userProfile/xmark.png",
                                                height: 14.w,
                                                width: 14.w,
                                              )),

                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: ()=> QuickActions.shareImage(imageData.bytes,
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(26.w, 10.w, 17.w, 0.w),
                          height: 100.w,
                          child: Column(
                            children: [
                              Text('SHARE SCREENSHOT',style: SafeGoogleFont('DM Sans',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                              SizedBox(height: 16.w,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 60.w,
                                    width: 50.w,
                                    child: Image.asset("assets/png/userProfile/Facebook.png",
                                      height: 60.w,
                                      width: 50.w,),
                                  ),
                                  Container(
                                    height: 60.w,
                                    width: 36.w,
                                    child: Image.asset("assets/png/userProfile/Twitter.png",
                                      height: 60.w,
                                      width: 50.w,),
                                  ),

                                  Container(
                                    height: 60.w,
                                    width: 54.w,
                                    child: Image.asset("assets/png/userProfile/WhatsApp.png",
                                      height: 60.w,
                                      width: 50.w,),
                                  ),

                                  Container(
                                    height: 60.w,
                                    width: 54.w,
                                    child: Image.asset("assets/png/userProfile/Messenger.png",
                                      height: 60.w,
                                      width: 50.w,),
                                  ),

                                ],
                              )

                            ],
                          ),
                        ),
                      )

                    ],
                  )),
            ),
          );
        });
  }

  static shareLog(BuildContext context) async {
    var shareLogFuntion = (String? sdkPath) async {
      if (sdkPath != null) {
        var logZipPath = sdkPath + '/log.zip';
        var logZipFile = File(logZipPath);
        if (logZipFile.existsSync()) {
          await logZipFile.delete();
          print('delete log zip path: $logZipPath');
        }

        var encoder = ZipFileEncoder();
        encoder.create(logZipPath);
        for (var i = 1; i <= 3; i++) {
          var logFile = File('$sdkPath/zegoavlog$i.txt');
          if (logFile.existsSync()) {
            print('$sdkPath/zegoavlog$i.txt exists');
            encoder.addFile(logFile);
          }
        }
        encoder.close();

        Share.shareFiles([logZipPath], subject: '日志', text: '分享');
      }
    };

    if (Platform.isAndroid) {
      getExternalStorageDirectories().then((dir) async {
        var sdkPath = dir?[0].path;
        print('sdk log path: $sdkPath');
        await shareLogFuntion(sdkPath);
      });
    } else if (Platform.isIOS || Platform.isMacOS) {
      getTemporaryDirectory().then((dir) async {
        print('sdk log path: ${dir.path}/ZegoLogs');
        await shareLogFuntion(dir.path + '/ZegoLogs');
      });
    } else if (Platform.isWindows) {
      getApplicationSupportDirectory().then((dir) async {
        print(
            'sdk log path: ${dir.path}/../../zego_express_engine_example.exe.ZEGO.SDK/ZegoLogs');
        Clipboard.setData(ClipboardData(
            text:
            '${dir.path}/../../zego_express_engine_example.exe.ZEGO.SDK/ZegoLogs'));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('日志路径已复制到剪贴板')));
      });
    }
  }
}
