part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}
class LoadingAppState extends AppState {
}

class GotLocationAppState extends AppState{}
class GotPrayerTimesAppState extends AppState {}

class ToggleIconAppState extends AppState {}
class PlaySoundAppState extends AppState {}
class PauseSoundAppState extends AppState {}
class DownloadSoundAppState extends AppState {}
class ChangeQuranSoundActiveState extends AppState {}
class SetCurrentPageNumberAppState extends AppState {}
class IncrementAzkarTimesAppState extends AppState {}
class ClearTimesAppState extends AppState {}

class ErrorAppState extends AppState {}