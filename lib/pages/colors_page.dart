import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ColorsPage extends StatefulWidget {
  const ColorsPage({Key? key}) : super(key: key);

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Card Colors'),
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: const Text(
                  'Click this color to Select the first color for the background gradient'),
              trailing: ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 4,
                color: ColorsPageController.firstColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = ColorsPageController.firstColor;
                  if (!(await colorPickerFirstDialog())) {
                    setState(() {
                      ColorsPageController.setFirstColor(colorBeforeDialog);
                    });
                  }
                },
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: const Text(
                  'Click this color to Select the second color for the background gradient'),
              trailing: ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 4,
                color: ColorsPageController.secondColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = ColorsPageController.firstColor;
                  if (!(await colorPickerSecondDialog())) {
                    setState(() {
                      ColorsPageController.setSecondColor(colorBeforeDialog);
                    });
                  }
                },
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: const Text(
                  'Click this color to Select the second color for the background gradient'),
              trailing: ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 4,
                color: ColorsPageController.textColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = ColorsPageController.firstColor;
                  if (!(await colorPickerTextDialog())) {
                    setState(() {
                      ColorsPageController.setTextColor(colorBeforeDialog);
                    });
                  }
                },
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 300.0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    gradient: LinearGradient(
                      colors: [
                        ColorsPageController.firstColor,
                        ColorsPageController.secondColor,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: Text(
                    'Example text so you can choose the text color better',
                    style: GoogleFonts.roboto(
                      fontSize: 30.0,
                      color: ColorsPageController.textColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.of(context).pushNamed('PreviewPage');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> colorPickerFirstDialog() async {
    return ColorPicker(
      color: ColorsPageController.firstColor,
      onColorChanged: (Color color) =>
          setState(() => ColorsPageController.setFirstColor(color)),
      heading: const Text('Select color'),
      subheading: const Text('Select color shade'),
    ).showPickerDialog(context);
  }

  Future<bool> colorPickerSecondDialog() async {
    return ColorPicker(
      color: ColorsPageController.secondColor,
      onColorChanged: (Color color) =>
          setState(() => ColorsPageController.setSecondColor(color)),
      heading: const Text('Select color'),
      subheading: const Text('Select color shade'),
    ).showPickerDialog(context);
  }

  Future<bool> colorPickerTextDialog() async {
    return ColorPicker(
      color: ColorsPageController.textColor,
      onColorChanged: (Color color) =>
          setState(() => ColorsPageController.setTextColor(color)),
      heading: const Text('Select color'),
      subheading: const Text('Select color shade'),
    ).showPickerDialog(context);
  }
}

class ColorsPageController extends ControllerMVC {
  static Color _firstColor = Colors.blueGrey;
  static Color get firstColor => _firstColor;
  static Color setFirstColor(Color newColor) => _firstColor = newColor;

  static Color _secondColor = Colors.grey;
  static Color get secondColor => _secondColor;
  static Color setSecondColor(Color newColor) => _secondColor = newColor;

  static Color _textColor = Colors.white;
  static Color get textColor => _textColor;
  static Color setTextColor(Color newColor) => _textColor = newColor;
}
