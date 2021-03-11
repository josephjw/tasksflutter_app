import 'package:flutter/material.dart';

class CustomEditText extends StatefulWidget {
  final String label;
  final Function(String) validator;
  final Function onTextChange;
  final Function(String) onsubmit;

  final TextInputType inputType;
  final int maxLength;
  final bool isEnabled;
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool isPassword;
  final bool isMandatoryField;
  final bool obscureText;
  final Color textcolor;

  const CustomEditText({
    Key key,
    this.label,
    this.validator,
    this.inputType,
    this.maxLength,
    this.onTextChange,
    this.onsubmit,
    this.isEnabled,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword,
    this.isMandatoryField,
    this.obscureText, this.textcolor,
  }) : super(key: key);

  @override
  _CustomEditTextState createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  @override
  Widget build(BuildContext context) {
    bool isMandatoryField = widget.isMandatoryField ?? false;
    bool obscureText = widget.obscureText ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          enabled: widget.isEnabled,
          textInputAction: TextInputAction.go,
          maxLength: widget.maxLength,
          keyboardType: widget.inputType,
          onChanged: widget.onTextChange,
          cursorColor: widget.textcolor ?? Theme.of(context).hintColor,
          obscureText: obscureText,
          onFieldSubmitted: widget.onsubmit,
          style: TextStyle(color: widget.textcolor ?? Theme.of(context).hintColor),
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsetsDirectional.only(start: 2.0),
                      child: Icon(widget.prefixIcon),
                    ),
              suffixIcon: widget.suffixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsetsDirectional.only(start: 2.0),
                      child: Icon(widget.suffixIcon)),
              counterText: '',

              focusColor: widget.textcolor ?? Theme.of(context).hintColor,
              hintText: 'Enter ${widget.label}',
              labelText:
                  isMandatoryField ? '*${widget.label}' : '${widget.label}',
              border: UnderlineInputBorder(),
              hintStyle:
                  TextStyle(fontSize: 14, color:widget.textcolor ?? Theme.of(context).hintColor)),
          validator: widget.validator,
        ),
        // Divider(
        //   color: Theme.of(context).dividerColor,
        // )
      ],
    );
  }
}
