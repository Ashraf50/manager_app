import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/shared_pref.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    String? savedLang = sharedPreferences!.getString('lang');
    if (savedLang != null) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(AppChangeLanguage(langCode: savedLang));
    }

    on<LanguageEvent>((event, emit) {
      if (event is ArabicLanguageEvent) {
        sharedPreferences!.setString('lang', 'ar');
        emit(AppChangeLanguage(langCode: 'ar'));
      } else if (event is EnglishLanguageEvent) {
        sharedPreferences!.setString('lang', 'en');
        emit(AppChangeLanguage(langCode: 'en'));
      }
    });
  }
}
