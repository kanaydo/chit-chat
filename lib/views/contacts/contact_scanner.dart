import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_base_app/views/contacts/bloc/add_contact_cubit.dart';

class ContactScanner extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {

    void _onQRViewCreated(QRViewController controller) {
      controller.scannedDataStream.listen((scanData) {
        if (scanData != null) {
          BlocProvider.of<AddContactCubit>(context).scanData(scanData);
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
