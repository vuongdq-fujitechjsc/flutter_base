import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../utilities/utility.dart';

class TextfieldWithTitle extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final maxLength;
  final maxLine;
  final minLine;
  final textColor;
  final hintColor;
  final cursorColor;
  final inputFormat;
  final double fontSize;
  final FontWeight fontWeight;
  final enableEdit;
  final TextInputType textInputType;
  final Function(String) onChange;
  final TextInputAction textInputAction;
  final bool enableInteractiveSelection;
  final String errorText;

  TextfieldWithTitle({
    this.title: "",
    this.hint: "",
    this.controller,
    this.maxLength,
    this.minLine,
    this.maxLine: 1,
    this.textColor: Color.COLOR_TEXT_1,
    this.hintColor: Color.COLOR_TEXT_HINT,
    this.cursorColor: Color.COLOR_TEXT_1,
    this.fontSize: 15,
    this.enableEdit: true,
    this.onChange,
    this.fontWeight: FontWeight.normal,
    this.textInputAction,
    this.textInputType: TextInputType.text,
    this.enableInteractiveSelection: true,
    this.inputFormat,
    this.errorText,
  });

  @override
  _TextfieldWithTitleState createState() => _TextfieldWithTitleState();
}

class _TextfieldWithTitleState extends State<TextfieldWithTitle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: widget.fontSize,
                color: HexColor(widget.textColor))),
        SizedBox(
          height: 0,
        ),
        TextField(
          style: TextStyle(
              color: widget.enableEdit
                  ? HexColor(widget.textColor)
                  : HexColor(Color.COLOR_TEXT_DISABLE),
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight),
          maxLines: widget.maxLine,
          minLines: widget.minLine,
          maxLength: widget.maxLength,
          onChanged: (text) {
            if (widget.onChange != null) {
              widget.onChange(text);
            }
          },
          enableInteractiveSelection: widget.enableInteractiveSelection,
          cursorColor: HexColor(widget.cursorColor),
          controller: widget.controller,
          enabled: widget.enableEdit,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormat != null
              ? [
                  new FilteringTextInputFormatter.allow(
                      RegExp(widget.inputFormat)),
                ]
              : null,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor(Color.COLOR_DIVIDER))),
            counterText: '',
            hintText: widget.hint,
            hintStyle: TextStyle(
                color: HexColor(widget.hintColor),
                fontWeight: widget.fontWeight,
                fontSize: widget.fontSize),
            errorText: widget.errorText,
             errorStyle: TextStyle(
                  fontSize: Dimension.textSize10,
                ),
          ),
        ),
      ],
    ));
  }
}

class PasswordTextfieldWithTitle extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final maxLength;
  final maxLine;
  final textColor;
  final hintColor;
  final cursorColor;
  final isSecureText;
  final inputFormat;
  final double fontSize;
  final Function(String) onChange;
  final bool enableInteractiveSelection;
  final String errorText;

  PasswordTextfieldWithTitle({
    this.title: "",
    this.hint: "",
    this.controller,
    this.maxLength: 30,
    this.maxLine: 1,
    this.textColor: Color.COLOR_TEXT_1,
    this.hintColor: Color.COLOR_TEXT_HINT,
    this.cursorColor: Color.COLOR_TEXT_1,
    this.isSecureText: false,
    this.fontSize: 15,
    this.inputFormat,
    this.enableInteractiveSelection: true,
    this.onChange,
    this.errorText,
  });

  @override
  _PasswordTextfieldWithTitleState createState() =>
      _PasswordTextfieldWithTitleState();
}

class _PasswordTextfieldWithTitleState
    extends State<PasswordTextfieldWithTitle> {
  bool isShowText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: widget.fontSize,
                color: HexColor(widget.textColor))),
        SizedBox(
          height: 0,
        ),
        Stack(
          children: [
            TextField(
              style: TextStyle(
                  color: HexColor(widget.textColor), fontSize: widget.fontSize),
              maxLines: widget.maxLine,
              maxLength: widget.maxLength,
              obscureText: !isShowText,
              cursorColor: HexColor(widget.cursorColor),
              controller: widget.controller,
              enableInteractiveSelection: widget.enableInteractiveSelection,
              onChanged: (string) {
                if (string.length == 0) {
                  setState(() {
                    isShowText = false;
                  });
                }
                if (widget.onChange != null) {
                  widget.onChange(string);
                }
              },
              inputFormatters: widget.inputFormat != null
                  ? [
                      new FilteringTextInputFormatter(
                          RegExp(widget.inputFormat),
                          allow: true),
                    ]
                  : [
                      new FilteringTextInputFormatter(RegExp(" "), allow: false)
                    ],
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(Color.COLOR_DIVIDER))),
                counterText: '',
                hintText: widget.hint,
                hintStyle: TextStyle(
                    color: HexColor(widget.hintColor),
                    fontSize: widget.fontSize),
                contentPadding:
                    EdgeInsets.only(right: widget.isSecureText ? 40 : 0),
                errorText: widget.errorText,
                errorStyle: TextStyle(
                  fontSize: Dimension.textSize10,
                ),
              ),
            ),
            () {
              if (widget.isSecureText) {
                return Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: isShowText
                            ? Image.asset(AssetUtils.instance()
                                .getImageUrl('ic_login_hide_password.png'))
                            : Image.asset(
                                AssetUtils.instance()
                                    .getImageUrl('ic_login_show_password.png'),
                                color: HexColor(Color.COLOR_TEXT_4),
                              ),
                        onPressed: () => {_tapChangeShowPassword()}));
              } else {
                return Container(
                  width: 0,
                  height: 0,
                );
              }
            }()
          ],
        ),
      ],
    ));
  }

  void _tapChangeShowPassword() {
    setState(() {
      isShowText = !isShowText;
    });
  }
}
