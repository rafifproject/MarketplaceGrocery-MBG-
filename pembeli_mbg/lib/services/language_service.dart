import 'package:flutter/foundation.dart';

/// Simple reactive language service for toggling between Indonesian ('id') and English ('en').
class LanguageService {
  LanguageService._();
  static final LanguageService instance = LanguageService._();

  final ValueNotifier<String> language = ValueNotifier<String>('id');

  bool get isEnglish => language.value == 'en';

  void setLanguage(String langCode) {
    if (language.value != langCode) {
      language.value = langCode;
    }
  }

  /// Translate helper: returns English string if current language is 'en', otherwise Indonesian string.
  String tr(String id, String en) {
    return language.value == 'en' ? en : id;
  }
}
