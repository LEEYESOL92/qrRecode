import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:innerview_biz/mainPages/qrScanInfo.dart';

class QRScan extends StatelessWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          TextButton.icon(
              onPressed: () => _scan(),
              // onPressed: () {},
              icon: Icon(Icons.qr_code_scanner_outlined),
              label: Text('기업정보 QRScan'))
        ],
      ),
    ));
  }

  Future<bool> _getStatuses() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.camera].request();

    if (await Permission.camera.isGranted &&
        await Permission.storage.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future _scan() async {
    await _getStatuses();
    //스캔 시작 - 이때 스캔 될때까지 blocking
    String? barcode = await scanner.scan();
    if (barcode != null) {
      Get.offAll(QRScanInfo(
        qrData: barcode,
      ));

      // Get.toNamed('/question', arguments: barcode);
      // print(barcode);
    }
    //스캔 완료하면 _output 에 문자열 저장하면서 상태 변경 요청.
    // setState(() => _output = barcode!);
  }
}
