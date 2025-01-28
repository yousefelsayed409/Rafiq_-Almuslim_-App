part of 'quran_azkar_cubit.dart';

@immutable
sealed class QuranAzkarState {}

final class QuranAzkarInitial extends QuranAzkarState {}
class SurahState extends QuranAzkarState {}

class QuranAzkarLoaded extends QuranAzkarState {
  final List<Surah> surahs;
  QuranAzkarLoaded(this.surahs);
}

class QuranAzkarError extends QuranAzkarState {
  final String message;
  QuranAzkarError(this.message);
}