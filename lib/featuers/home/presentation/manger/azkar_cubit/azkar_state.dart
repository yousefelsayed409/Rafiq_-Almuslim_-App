part of 'azkar_cubit.dart';

@immutable
sealed class AzkarState {}

final class AzkarInitial extends AzkarState {}
class SharedPreferencesState extends AzkarState {}

class greetingState extends AzkarState {}

class LoadRemindersState extends AzkarState {}

class ShowTimePickerState extends AzkarState {}

class AddReminderState extends AzkarState {}

class DeleteReminderState extends AzkarState {}

class OnTimeChangedState extends AzkarState {}

