import 'dart:io';
import 'dart:typed_data';

import 'package:business_card_creator/pages/colors_page.dart';
import 'package:business_card_creator/pages/config_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:widget_to_image/widget_to_image.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> shareImage() async {
    ByteData byteData =
        await WidgetToImage.repaintBoundaryToImage(_globalKey, pixelRatio: 5.0);

    Directory tempDir = await getTemporaryDirectory();
    final File file =
        await File(tempDir.path + '/123.png').writeAsBytes(byteData.buffer.asUint8List());
    Share.shareFiles([file.path]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Final Result'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await shareImage();
          Navigator.of(context).popUntil((route) => route.settings.name == 'HomePage');
        },
        label: Text('Share Image'.toUpperCase()),
        icon: const Icon(Icons.share),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsPageController.firstColor,
                ColorsPageController.secondColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: FileImage(ConfigPageController.photo),
                backgroundColor: Colors.white,
                radius: 50.0,
              ),
              const SizedBox(height: 16.0),
              Text(
                ConfigPageController.name,
                style: GoogleFonts.roboto(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                ConfigPageController.profession.toUpperCase(),
                style: GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(
                height: 16.0,
                width: MediaQuery.of(context).size.width * 0.4,
                child: const Divider(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32.0),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 32.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                elevation: 5.0,
                child: ListTile(
                  leading: Icon(Icons.phone, color: ColorsPageController.firstColor),
                  title: Text(
                    ConfigPageController.phone,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: ColorsPageController.firstColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 32.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                elevation: 5.0,
                child: ListTile(
                  leading: Icon(Icons.mail, color: ColorsPageController.firstColor),
                  title: Text(
                    ConfigPageController.email,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: ColorsPageController.firstColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
