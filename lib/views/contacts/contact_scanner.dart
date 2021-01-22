/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 9:58 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_base_app/views/contacts/bloc/add_contact_cubit.dart';

class ContactScanner extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {

    var bloc = BlocProvider.of<AddContactCubit>(context);

    void _onQRViewCreated(QRViewController controller) {
      controller.scannedDataStream.listen((scanData) {
        if (scanData != null) {
          bloc.scanData(scanData);
          controller.dispose();
        }
      });
    }

    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),
      ],
    );
  }
}
