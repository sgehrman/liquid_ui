import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TwoColors extends StatefulWidget {
  const TwoColors({
    @required this.startColor,
    @required this.endColor,
    @required this.onChange,
  });

  final Color startColor;
  final Color endColor;

  final void Function(Color start, Color end) onChange;

  @override
  _TwoColorsState createState() => _TwoColorsState();
}

class _TwoColorsState extends State<TwoColors> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ListRow(
            title: 'Start Color',
            leading: Container(
              height: 40,
              width: 40,
              color: widget.startColor ?? Colors.white12,
            ),
            onTap: () async {
              final newColor =
                  await ColorEditorDialog.show(context, widget.startColor);

              widget.onChange(newColor, widget.endColor);
            },
          ),
        ),
        Flexible(
          child: ListRow(
            title: 'End Color',
            leading: Container(
              height: 40,
              width: 40,
              color: widget.endColor ?? Colors.white12,
            ),
            onTap: () async {
              final newColor =
                  await ColorEditorDialog.show(context, widget.endColor);

              widget.onChange(widget.startColor, newColor);
            },
          ),
        ),
      ],
    );
  }
}

class ColorEditorDialog extends StatefulWidget {
  const ColorEditorDialog({
    @required this.color,
  });

  final Color color;

  static Future<Color> show(
    BuildContext context,
    Color color,
  ) {
    return showDialog<Color>(
      context: context,
      barrierDismissible: true,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: const Text('Edit Color'),
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600.0),
            child: SingleChildScrollView(
              child: ColorEditorDialog(color: color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  _ColorEditorDialogState createState() => _ColorEditorDialogState();
}

class _ColorEditorDialogState extends State<ColorEditorDialog> {
  HSVColor currentColor;

  @override
  void initState() {
    super.initState();

    // color picker crashes if you send nil.  An invalid themeset might have null colors from bad scan etc.
    currentColor = HSVColor.fromColor(
      widget.color ?? Colors.white,
    );
  }

  void changeColorHsv(HSVColor hsvColor) {
    currentColor = hsvColor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HsvColorPicker(
          showLabel: false,
          pickerAreaBorderRadius: const BorderRadius.all(Radius.circular(8)),
          enableAlpha: false,
          pickerColor: currentColor,
          onColorChanged: changeColorHsv,
        ),
        Text(currentColor.toString()),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',
              style: TextStyle(color: Theme.of(context).accentColor)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(currentColor.toColor());
          },
          child: Text('OK',
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ],
    );
  }
}
