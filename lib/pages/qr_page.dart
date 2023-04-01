import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey _globalKey = GlobalKey();

  QRViewController? controller;
  Barcode? result;
  // void qr(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((event) {
  //     setState(() {
  //       result = event;
  //     });
  //   });
  // }

  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        if (result != null) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '${result!.code}');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFf5ebdc), //backgroundColor: Color(0xFFD3AF9C),
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('QR TABLE', style: TextStyle(color: Colors.black54),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // закругление углов
              child: Container(
                height: _screenWidth * 0.8,
                width: _screenWidth * 0.8,
                child: QRView(key: _globalKey, onQRViewCreated: qr),
              ),
            ),
            // Center(
            //   child: (result != null)
            //       ? Text('${result!.code}')
            //       : Text('Scan a QR Code'),
            // )

            // Center(
            //   child:
            //   (result != null)
            //       ? Navigator.pushNamed(context, '${result!.code}')
            //       : Container(
            //     child: Text('Scan a QR Code'),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
