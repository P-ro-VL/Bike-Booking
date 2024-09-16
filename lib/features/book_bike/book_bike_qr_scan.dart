import 'package:book_bike/features/book_bike/book_bike_in_journey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../global_controller.dart';
import '../../l10n/app_l18.dart';

class BookBikeQRScan extends StatefulWidget {
  const BookBikeQRScan({super.key});

  @override
  State<BookBikeQRScan> createState() => _BookBikeQRScanState();
}

class _BookBikeQRScanState extends State<BookBikeQRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final controller = Get.find<GlobalController>();
  late bool scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          Ln.i?.bikeIrentTitle ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: Stack(
        children: [
          QRView(
              key: qrKey,
              overlay:
                  QrScannerOverlayShape(cutOutHeight: 350, cutOutWidth: 350),
              onQRViewCreated: (_) {
                _.scannedDataStream.listen((scanData) {
                  if (scanned) return;
                  setState(() {
                    final data = scanData.code!.split('_');
                    if (data[0] == 'BB') {
                      final bikeId = int.parse(data[1]);
                      final stationId = int.parse(data[2]);

                      final bike = controller.stations
                          .map((e) => controller.getBikes(stationId))
                          .expand((element) => element)
                          .firstWhere((element) => element.id == bikeId);
                      final station = controller.stations
                          .firstWhere((element) => element.id == stationId);

                      scanned = true;

                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                content: Text(
                                  (Ln.i?.bikeIfoundBikeMessage ?? '')
                                      .replaceAll('%s', bikeId.toString())
                                      .replaceAll('%x', station.name ?? '--'),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        scanned = false;
                                        Get.back();
                                      },
                                      child: Text(Ln.i?.commonIcancel ?? '')),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                        Get.off(BookBikeInJourneyPage(
                                            bike: bike, station: station));
                                      },
                                      child: Text(Ln.i?.commonIconfirm ?? '')),
                                ],
                              ));
                    }
                  });
                });
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              Ln.i?.bikeIqrInstruction ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ).marginOnly(bottom: 40),
        ],
      ),
    );
  }
}
