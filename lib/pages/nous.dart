import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:photo_view/photo_view.dart';

class Nous extends StatefulWidget {
  const Nous({super.key});

  @override
  State<StatefulWidget> createState() {
    //
    return _Nous();
  }
}

class _Nous extends State<Nous> {
  //
  String pathPDF = "";
  //
  bool lumiere = false;
  //
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  //
  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    fromAsset('assets/FLYERS.pdf', 'DOC-20240108-WA0047.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       //
          //       setState(() {
          //         //
          //         lumiere = !lumiere;
          //         print("lumiere: $lumiere");
          //       });
          //     },
          //     icon: SvgPicture.asset(
          //       'assets/FLYERS.svg',
          //       width: 30,
          //       height: 30,
          //       semanticsLabel: 'FLYERS.svg',
          //       color: Colors.white,
          //     ),
          //   ),
          // ],
          ),
      body: PageView(
        children: List.generate(
          14,
          (index) => PhotoView(
            imageProvider: AssetImage(
              "assets/PRESENTATION-${index < 9 ? '0${index + 1}' : index}.jpg",
            ),
          ),
        ),
      ),
    );
  }
}
