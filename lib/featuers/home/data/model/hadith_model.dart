class HadithModels {
  final String key;
  final String nameHadith;
  final String textHadith;
  final String explanationHadith;
  final String translateNarrator;
  // final String audioHadith;

  HadithModels({
    required this.key,
    required this.nameHadith,
    required this.textHadith,
    required this.explanationHadith,
    required this.translateNarrator,
    // required this.audioHadith,
  });

  // لتحويل الكائن إلى خريطة
  Map<String, dynamic> toMap() {
    return {
      "key": key,
      "nameHadith": nameHadith,
      "textHadith": textHadith,
      "explanationHadith": explanationHadith,
      "translateNarrator": translateNarrator,
      // "audioHadith": audioHadith,
    };
  }

  // لإنشاء كائن من الخريطة
  factory HadithModels.fromMap(Map<String, dynamic> map) {
    return HadithModels(
      key: map["key"] ?? '',
      nameHadith: map["nameHadith"] ?? '',
      textHadith: map["textHadith"] ?? '',
      explanationHadith: map["explanationHadith"] ?? '',
      translateNarrator: map["translateNarrator"] ?? '',
      // audioHadith: map["audioHadith"] ?? '',
    );
  }

  // لتحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "nameHadith": nameHadith,
      "textHadith": textHadith,
      "explanationHadith": explanationHadith,
      "translateNarrator": translateNarrator,
      // "audioHadith": audioHadith,
    };
  }

  // لإنشاء كائن من JSON
  factory HadithModels.fromJson(Map<String, dynamic> json) {
    return HadithModels(
      key: json["key"] ?? '',
      nameHadith: json["nameHadith"] ?? '',
      textHadith: json["textHadith"] ?? '',
      explanationHadith: json["explanationHadith"] ?? '',
      translateNarrator: json["translateNarrator"] ?? '',
      // audioHadith: json["audioHadith"] ?? '',
    );
  }
}
