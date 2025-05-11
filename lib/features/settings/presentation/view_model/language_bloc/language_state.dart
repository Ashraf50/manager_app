part of 'language_bloc.dart';

sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class AppChangeLanguage extends LanguageState {
  final String langCode;
  AppChangeLanguage({required this.langCode});
}
