import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:quranapp/core/widgets/widgets.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  String? lat, long;
  DateTime now = DateTime.now();
bool internetConnection = false;

  

  bool isPlaying = false;

  AudioPlayer quranSound = AudioPlayer();
  AudioPlayer azanSound = AudioPlayer();
  IconData soundIcon = Icons.play_arrow;
  bool quranSoundActive = false;
  String surahName = '';
  int surahNumber = 0;
  int currentPageNumber = 0;
  bool isCached = false;
  String quranSoundUrl = "";

  void setCurrentPageNumber(int pageNumber) {
    currentPageNumber = pageNumber;
    emit(SetCurrentPageNumberAppState());
  }

  void setSurahInfo(int number, String name) {
    surahNumber = number;
    if (name == 'اللهب') {
      name = 'المسد';
    }
    surahName = name;
  }

  void setUrlQuranSoundSrcOnline({required String urlSrc}) {
    quranSoundActive = true;
    quranSoundUrl = urlSrc;
    quranSound.setSourceUrl(urlSrc);
  }

  void setUrlQuranSoundSrcOffline({required String urlSrc}) {
    quranSoundActive = true;
    quranSound.setSourceDeviceFile(urlSrc);
  }

  void changeQuranSoundActive() {
    soundIcon = Icons.play_arrow;
    quranSoundActive = false;
    quranSound.stop();
    quranSound.seek(Duration.zero);
    isPlaying = false;
    emit(ChangeQuranSoundActiveState());
  }

  
  void togglePlay() {
    if (!isPlaying) {
      quranSound.play(quranSoundUrl as Source);
      soundIcon = Icons.pause;
      emit(PlaySoundAppState());
    } else {
      quranSound.pause();
      soundIcon = Icons.play_arrow;
      emit(PauseSoundAppState());
    }
    isPlaying = !isPlaying;

    quranSound.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed ||
          (!isCached && !internetConnection)) {
        quranSound.seek(Duration.zero);
        quranSound.stop();
        isPlaying = false;
        soundIcon = Icons.play_arrow;
        emit(PauseSoundAppState());
      }
    });
  }

  bool isDownloading = false;

  void downloadSurahSound() {
    isDownloading = true;
    soundIcon = Icons.download;
    emit(DownloadSoundAppState());
    DefaultCacheManager().downloadFile(quranSoundUrl).then((value) {
      isCached = true;
      isDownloading = false;
      defaultFlutterToast(
          msg: "تم تحميل السورة بنجاح", backgroundColor: Colors.green);
      soundIcon = Icons.play_arrow;
      emit(DownloadSoundAppState());
    });
  }

  


}
