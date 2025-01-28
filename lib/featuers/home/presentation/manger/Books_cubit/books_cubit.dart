import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/core/function/app_function.dart';
import 'package:quranapp/featuers/home/data/model/calss_model.dart';
import 'package:quranapp/featuers/home/data/model/sahih_model.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksInitial());
  static BooksCubit get(context) => BlocProvider.of<BooksCubit>(context);

  PageController? pageController;


  Future<List<Class>> getClasses() async {
    emit(ClassesLoading());

    try {
      final classes = await fetchClasses();

      emit(ClassesLoaded(classes));

      return classes;
    } catch (e, s) {
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
      emit(ClassesError(e));

      // In case of error, throw the exception
      throw e;
    }
  } 


   void selectClass(Class selectedClass) {
    emit(ClassSelected(selectedClass));
  }


  Future<List<SahihBukhariModels>> getAllSahihAlBukhari() async {
    // Emit loading state
    emit(ClassesLoading());

    try {
      // Fetch classes
      final classes = await fetchAllSahihBukari();

      // Emit loaded state
      emit(SahihsLoadedState(classes));

      // Return the fetched classes
      return classes;
    } catch (e, s) {
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
      emit(ClassesError(e));

      // In case of error, throw the exception
      throw e;
    }
  }

void sahihselectClass(SahihBukhariModels sahihselectedClass) {
    emit(SahihSelected(sahihselectedClass));
  }

  
}
