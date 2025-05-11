import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import '../../../../core/constant/app_styles.dart';
import '../../../../generated/l10n.dart';
import '../view_model/language_bloc/language_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<LanguageBloc>(context).state;
    if (state is AppChangeLanguage) {
      _selectedLanguage = state.langCode;
    }
  }

  void _changeLanguage(String langCode) {
    setState(() {
      _selectedLanguage = langCode;
    });
    if (langCode == 'ar') {
      BlocProvider.of<LanguageBloc>(context).add(ArabicLanguageEvent());
    } else {
      BlocProvider.of<LanguageBloc>(context).add(EnglishLanguageEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).language,
                  style: AppStyles.textStyle16Black,
                ),
                _buildToggleLanguageButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleLanguageButton() {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildSingleOption('Ar', 'ar'),
          _buildSingleOption('En', 'en'),
        ],
      ),
    );
  }

  Widget _buildSingleOption(String label, String langCode) {
    final isSelected = _selectedLanguage == langCode;
    return Expanded(
      child: GestureDetector(
        onTap: () => _changeLanguage(langCode),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.activeBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
