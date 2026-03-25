import 'package:flutter/material.dart';
import 'app_state.dart';

String tr(BuildContext context, String key) {
  return AppState.of(context).tr(key);
}