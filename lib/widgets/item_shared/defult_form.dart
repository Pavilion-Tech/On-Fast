import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

class DefaultForm extends StatelessWidget {
  DefaultForm({
    required this.hint,
     this.suffix,
     this.prefix,
     this.type,
     this.onChange,
     this.onTap,
    this.maxLines = 1
});

  String hint;
  int maxLines;
  Widget? suffix;
  Widget? prefix;
  TextInputType? type;
  ValueChanged<String>? onChange;
  GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: defaultColor,
      keyboardType: type,
      onChanged: onChange,
      onTap: onTap,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: defaultColor)
        ),
        suffixIcon: suffix,
        prefixIcon: prefix,
        hintText: hint,hintStyle: TextStyle(color: Colors.grey)
      ),
    );
  }
}
