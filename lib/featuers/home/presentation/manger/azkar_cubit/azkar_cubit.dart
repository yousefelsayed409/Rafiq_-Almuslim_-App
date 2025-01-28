import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quranapp/core/widgets/azkar_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());
   static AzkarCubit get(context) => BlocProvider.of<AzkarCubit>(context);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  var controller = ScrollController();

  /// Shared Preferences
  // Save & Load Azkar Text Font Size
  saveAzkarFontSize(double fontSizeAzkar) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setDouble("font_azkar_size", fontSizeAzkar);
    emit(SharedPreferencesState());
  }

  loadAzkarFontSize() async {
    SharedPreferences prefs = await _prefs;
    AzkarItem.fontSizeAzkar = prefs.getDouble('font_azkar_size') ?? 18;
    print('get font size ${prefs.getDouble('font_azkar_size')}');
    emit(SharedPreferencesState());
  }

  

  
}
