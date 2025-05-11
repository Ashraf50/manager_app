// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome Back!`
  String get welcome {
    return Intl.message(
      'Welcome Back!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `To keep connected with us please login with your personal info`
  String get welcomeDescription {
    return Intl.message(
      'To keep connected with us please login with your personal info',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get email {
    return Intl.message(
      'Enter your email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get password {
    return Intl.message(
      'Enter your Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password!`
  String get forget {
    return Intl.message(
      'Forgot Password!',
      name: 'forget',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `All Tickets`
  String get allTickets {
    return Intl.message(
      'All Tickets',
      name: 'allTickets',
      desc: '',
      args: [],
    );
  }

  /// `Closed Tickets`
  String get closedTickets {
    return Intl.message(
      'Closed Tickets',
      name: 'closedTickets',
      desc: '',
      args: [],
    );
  }

  /// `Open Tickets`
  String get openTickets {
    return Intl.message(
      'Open Tickets',
      name: 'openTickets',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Daily Respond`
  String get dailyRespond {
    return Intl.message(
      'Daily Respond',
      name: 'dailyRespond',
      desc: '',
      args: [],
    );
  }

  /// `Annual tickets average`
  String get annualTickets {
    return Intl.message(
      'Annual tickets average',
      name: 'annualTickets',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get read {
    return Intl.message(
      'Read',
      name: 'read',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Filter Tickets`
  String get filterTickets {
    return Intl.message(
      'Filter Tickets',
      name: 'filterTickets',
      desc: '',
      args: [],
    );
  }

  /// `from`
  String get from {
    return Intl.message(
      'from',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Select Ticketian`
  String get selectTicketian {
    return Intl.message(
      'Select Ticketian',
      name: 'selectTicketian',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message(
      'Show All',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `chat`
  String get chat {
    return Intl.message(
      'chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Add Ticketian`
  String get addTicketian {
    return Intl.message(
      'Add Ticketian',
      name: 'addTicketian',
      desc: '',
      args: [],
    );
  }

  /// `Create New`
  String get createNew {
    return Intl.message(
      'Create New',
      name: 'createNew',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Logout Account`
  String get logoutAccount {
    return Intl.message(
      'Logout Account',
      name: 'logoutAccount',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `In Progress Tickets`
  String get ProgressTickets {
    return Intl.message(
      'In Progress Tickets',
      name: 'ProgressTickets',
      desc: '',
      args: [],
    );
  }

  /// `Technicians`
  String get technicians {
    return Intl.message(
      'Technicians',
      name: 'technicians',
      desc: '',
      args: [],
    );
  }

  /// `Recent Tickets`
  String get recentTickets {
    return Intl.message(
      'Recent Tickets',
      name: 'recentTickets',
      desc: '',
      args: [],
    );
  }

  /// `No Tickets`
  String get no_tickets {
    return Intl.message(
      'No Tickets',
      name: 'no_tickets',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Resolved`
  String get resolved {
    return Intl.message(
      'Resolved',
      name: 'resolved',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `UnKnown`
  String get unKnown {
    return Intl.message(
      'UnKnown',
      name: 'unKnown',
      desc: '',
      args: [],
    );
  }

  /// `Assign`
  String get assign {
    return Intl.message(
      'Assign',
      name: 'assign',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to finish this Ticket?`
  String get sure_finish_Ticket {
    return Intl.message(
      'Are you sure you want to finish this Ticket?',
      name: 'sure_finish_Ticket',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Finish`
  String get confirm_finish {
    return Intl.message(
      'Confirm Finish',
      name: 'confirm_finish',
      desc: '',
      args: [],
    );
  }

  /// `Ticketian Details`
  String get ticketian_details {
    return Intl.message(
      'Ticketian Details',
      name: 'ticketian_details',
      desc: '',
      args: [],
    );
  }

  /// `Edit Ticketian`
  String get edit_ticketian {
    return Intl.message(
      'Edit Ticketian',
      name: 'edit_ticketian',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirm_delete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirm_delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Ticketian?`
  String get sure_delete_ticketian {
    return Intl.message(
      'Are you sure you want to delete this Ticketian?',
      name: 'sure_delete_ticketian',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Check email or password`
  String get check_email {
    return Intl.message(
      'Check email or password',
      name: 'check_email',
      desc: '',
      args: [],
    );
  }

  /// `your password is too short`
  String get pass_short {
    return Intl.message(
      'your password is too short',
      name: 'pass_short',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get enter_valid_email {
    return Intl.message(
      'Enter a valid email',
      name: 'enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Ticketian Created Successfully`
  String get ticketian_created_successfully {
    return Intl.message(
      'Ticketian Created Successfully',
      name: 'ticketian_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `hours ago`
  String get hour {
    return Intl.message(
      'hours ago',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Notification?`
  String get sure_delete_notification {
    return Intl.message(
      'Are you sure you want to delete this Notification?',
      name: 'sure_delete_notification',
      desc: '',
      args: [],
    );
  }

  /// `notification deleted successfully`
  String get notification_deleted_successfully {
    return Intl.message(
      'notification deleted successfully',
      name: 'notification_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please select a profile picture`
  String get Please_select_profile_picture {
    return Intl.message(
      'Please select a profile picture',
      name: 'Please_select_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid phone number`
  String get enter_valid_phone {
    return Intl.message(
      'Enter a valid phone number',
      name: 'enter_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Check your data`
  String get check_data {
    return Intl.message(
      'Check your data',
      name: 'check_data',
      desc: '',
      args: [],
    );
  }

  /// `empty field`
  String get empty_field {
    return Intl.message(
      'empty field',
      name: 'empty_field',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get Profile_updated {
    return Intl.message(
      'Profile updated successfully',
      name: 'Profile_updated',
      desc: '',
      args: [],
    );
  }

  /// `null`
  String get null_value {
    return Intl.message(
      'null',
      name: 'null_value',
      desc: '',
      args: [],
    );
  }

  /// `Chose Photo`
  String get choose_photo {
    return Intl.message(
      'Chose Photo',
      name: 'choose_photo',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get take_photo {
    return Intl.message(
      'Take Photo',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get user_name {
    return Intl.message(
      'User Name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Manager Name`
  String get manager_name {
    return Intl.message(
      'Manager Name',
      name: 'manager_name',
      desc: '',
      args: [],
    );
  }

  /// `Ticketian Name`
  String get ticketian_name {
    return Intl.message(
      'Ticketian Name',
      name: 'ticketian_name',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get created_at {
    return Intl.message(
      'Created at',
      name: 'created_at',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Details`
  String get ticket_details {
    return Intl.message(
      'Ticket Details',
      name: 'ticket_details',
      desc: '',
      args: [],
    );
  }

  /// `No Details Available`
  String get no_details {
    return Intl.message(
      'No Details Available',
      name: 'no_details',
      desc: '',
      args: [],
    );
  }

  /// `Service Name`
  String get service_name {
    return Intl.message(
      'Service Name',
      name: 'service_name',
      desc: '',
      args: [],
    );
  }

  /// `Reset your password`
  String get reset_pass {
    return Intl.message(
      'Reset your password',
      name: 'reset_pass',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forget_password {
    return Intl.message(
      'Forget Password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `We well send an email with`
  String get reset_desc1 {
    return Intl.message(
      'We well send an email with',
      name: 'reset_desc1',
      desc: '',
      args: [],
    );
  }

  /// `instructions to reset your password`
  String get reset_desc2 {
    return Intl.message(
      'instructions to reset your password',
      name: 'reset_desc2',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get check_email_only {
    return Intl.message(
      'Check your email',
      name: 'check_email_only',
      desc: '',
      args: [],
    );
  }

  /// `password not match`
  String get pass_not_match {
    return Intl.message(
      'password not match',
      name: 'pass_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get create_new_pass {
    return Intl.message(
      'Create New Password',
      name: 'create_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `your new password must be different`
  String get create_pass1 {
    return Intl.message(
      'your new password must be different',
      name: 'create_pass1',
      desc: '',
      args: [],
    );
  }

  /// `from previous used password`
  String get create_pass2 {
    return Intl.message(
      'from previous used password',
      name: 'create_pass2',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code`
  String get enter_code {
    return Intl.message(
      'Enter Code',
      name: 'enter_code',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
