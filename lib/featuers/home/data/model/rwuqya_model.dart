
class RuqyaModel {
  final String category;
  final String count; // يجب أن يكون من النوع int
  final String description;
  final String reference;
  final String zekr;

  RuqyaModel({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.zekr,
  });

  // تحويل JSON إلى كائن RuqyaModel
  factory RuqyaModel.fromJson(Map<String, dynamic> json) {
    return RuqyaModel(
      category: json['category'] as String, // تأكد من أن هذا هو نوع البيانات الصحيح
      count: json['count'] , // تحويل إلى int مع معالجة الأخطاء
      description: json['description'] as String,
      reference: json['reference'] as String,
      zekr: json['zekr'] as String,
    );
  }

  // تحويل كائن RuqyaModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'count': count,
      'description': description,
      'reference': reference,
      'zekr': zekr,
    };
  }
}
