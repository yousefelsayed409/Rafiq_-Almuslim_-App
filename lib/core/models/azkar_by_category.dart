import 'package:quranapp/featuers/home/data/model/hadith_model.dart';
import 'package:quranapp/featuers/home/data/model/rwuqya_model.dart';

import 'azkar.dart';
import 'azkar_list.dart';

class AzkarByCategory {
  final List<Azkar> _azkarList = []; 
    final List<RuqyaModel> _rwqyaList = []; 
        final List<HadithModels> _hadithList = []; 




getHadithByCategory(String category) {
    return hadithDb
        .where(
          (element) => element.containsValue(category),
        )
        .forEach(
          (element) => _hadithList.add(
            HadithModels.fromJson(element),
          ),
        );
  }

  List<HadithModels> get hadithList => _hadithList;


  getrwqyaByCategory(String category) {
    return dbrwqya
        .where(
          (element) => element.containsValue(category),
        )
        .forEach(
          (element) => _rwqyaList.add(
            RuqyaModel.fromJson(element),
          ),
        );
  }

  List<RuqyaModel> get rwqyaList => _rwqyaList;

  getAzkarByCategory(String category) {
    return db
        .where(
          (element) => element.containsValue(category),
        )
        .forEach(
          (element) => _azkarList.add(
            Azkar.fromJson(element),
          ),
        );
  }

  List<Azkar> get azkarList => _azkarList;
}
