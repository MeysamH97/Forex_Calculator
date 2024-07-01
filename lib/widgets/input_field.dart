import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class NumberTextField extends StatefulWidget {
  final Color color;
  final double width;
  final TextEditingController textController;

  NumberTextField({required this.color, required this.width, required this.textController});

  @override
  _NumberTextFieldState createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {

  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(() {
      final text = widget.textController.text.replaceAll(',', '');
      try {
        final int number = int.parse(text.isEmpty ? '0' : text);
        final formattedText = _formatter.format(number);
        widget.textController.value = widget.textController.value.copyWith(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 50,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
      child: TextField(
        controller: widget.textController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: widget.color.withOpacity(0.25),
        ),
      ),
    );
  }
}