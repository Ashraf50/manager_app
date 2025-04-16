import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:manager_app/core/constant/app_styles.dart';

class FormattingTextField extends StatefulWidget {
  const FormattingTextField({super.key});

  @override
  FormattingTextFieldState createState() => FormattingTextFieldState();
}

class FormattingTextFieldState extends State<FormattingTextField> {
  final TextEditingController _textController = TextEditingController();
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;
  bool isStrikethrough = false;
  Color textColor = Colors.black;
  String selectedFont = 'Arial';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey),
              left: BorderSide(color: Colors.grey),
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(13),
              topLeft: Radius.circular(13),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.format_bold,
                  color: isBold ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isBold = !isBold;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.format_italic,
                  color: isItalic ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isItalic = !isItalic;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.format_underline,
                  color: isUnderline ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isUnderline = !isUnderline;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.format_strikethrough,
                  color: isStrikethrough ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isStrikethrough = !isStrikethrough;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.color_lens),
                color: textColor,
                onPressed: () {
                  _showColorPickerDialog();
                },
              ),
              IconButton(
                icon: const Icon(Icons.font_download),
                onPressed: () {
                  _showFontSelectionDialog();
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(13),
              bottomRight: Radius.circular(13),
            ),
          ),
          child: TextField(
            controller: _textController,
            maxLines: 5,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              decoration: _getTextDecoration(),
              color: textColor,
              fontFamily: selectedFont,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter your text',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  TextDecoration _getTextDecoration() {
    if (isUnderline && isStrikethrough) {
      return TextDecoration.combine(
          [TextDecoration.underline, TextDecoration.lineThrough]);
    } else if (isUnderline) {
      return TextDecoration.underline;
    } else if (isStrikethrough) {
      return TextDecoration.lineThrough;
    }
    return TextDecoration.none;
  }

  void _showColorPickerDialog() {
    SmartDialog.show(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose Text Color',
                  style: AppStyles.textStyle18black,
                ),
              ),
              BlockPicker(
                pickerColor: textColor,
                onColorChanged: (color) {
                  setState(() {
                    textColor = color;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFontSelectionDialog() {
    SmartDialog.show(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose Text Style',
                  style: AppStyles.textStyle18black,
                ),
              ),
              ListTile(
                title: const Text('Arial'),
                onTap: () {
                  setState(() {
                    selectedFont = 'Arial';
                  });
                  SmartDialog.dismiss();
                },
              ),
              ListTile(
                title: const Text('Times New Roman'),
                onTap: () {
                  setState(() {
                    selectedFont = 'Times New Roman';
                  });
                  SmartDialog.dismiss();
                },
              ),
              ListTile(
                title: const Text('Courier New'),
                onTap: () {
                  setState(() {
                    selectedFont = 'Courier New';
                  });
                  SmartDialog.dismiss();
                },
              ),
              ListTile(
                title: const Text('Georgia'),
                onTap: () {
                  setState(() {
                    selectedFont = 'Georgia';
                  });
                  SmartDialog.dismiss();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
