import 'package:flutter/material.dart';

class NameField extends TextFormField {
  NameField({
    super.key,
    super.autovalidateMode,
    required super.controller,
    required super.onSaved,
    super.onEditingComplete,
    super.validator,
    required super.decoration,
    super.textInputAction = TextInputAction.next,
    super.cursorColor,
    super.maxLength,
  }) : super();
}

class StartTimeField extends TextFormField {
  StartTimeField({
    super.key,
    super.autovalidateMode,
    required super.controller,
    required super.onSaved,
    super.onEditingComplete,
    super.validator,
    required super.decoration,
    super.textInputAction = TextInputAction.next,
    super.cursorColor,
    super.maxLength,
  }) : super();
}

class EndTimeField extends TextFormField {
  EndTimeField({
    super.key,
    super.autovalidateMode,
    required super.controller,
    required super.onSaved,
    super.onEditingComplete,
    super.validator,
    required super.decoration,
    super.textInputAction = TextInputAction.done,
    super.cursorColor,
    super.maxLength,
  }) : super();
}
