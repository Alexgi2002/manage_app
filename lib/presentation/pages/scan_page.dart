import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_app/presentation/widgets/shared/input_text.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();

    controller!.pauseCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (result != null) ? Text('RESULTADO: ${result!.code}') : const Text("Escanear código"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  setState(() {
                    result = scanData;
                  });
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                
                InputText(
                  textController: TextEditingController(), 
                  label: 'Código',
                  keyboardType: TextInputType.number
                ),

                SizedBox(height: 8,),

                FilledButton(
                  onPressed: () async {
                    context.pop();
                  }, 
                  child: const Text("CONFIRMAR")
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

}