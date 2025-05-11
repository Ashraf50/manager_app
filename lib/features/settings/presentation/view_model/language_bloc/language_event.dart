part of 'language_bloc.dart';

sealed class LanguageEvent {}

class InitialLanguageEvent extends LanguageEvent {}

class ArabicLanguageEvent extends LanguageEvent {}

class EnglishLanguageEvent extends LanguageEvent {}
