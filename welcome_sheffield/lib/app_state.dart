import 'package:flutter/material.dart';
import 'translations.dart';

class AppState extends StatefulWidget {
  final Widget child;

  const AppState({super.key, required this.child});

  static _AppStateState of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_AppStateInherited>();
    assert(result != null, 'No AppState found in context');
    return result!.data;
  }

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  String currentLanguage = 'en';

  void changeLanguage(String code) {
    setState(() {
      currentLanguage = code;
    });
  }

  String tr(String key) {
    return translations[currentLanguage]?[key] ??
        translations['en']?[key] ??
        key;
  }

  @override
  Widget build(BuildContext context) {
    return _AppStateInherited(
      data: this,
      child: widget.child,
    );
  }
}

class _AppStateInherited extends InheritedWidget {
  final _AppStateState data;

  const _AppStateInherited({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}