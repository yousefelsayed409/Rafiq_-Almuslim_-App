class AzkarModel {
  int? id;
  String? name;
  AzkarModel(this.id, this.name);

  AzkarModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
} 



class AzkarDetailModel{
   int? sectionId;
  String? count;
  String? description;
  String? reference;
  String? content;

  AzkarDetailModel(this.sectionId, this.count, this.description, this.content,
      this.reference);

  AzkarDetailModel.fromJson(Map<String, dynamic> json) {
    sectionId = json["section_id"];
    count = json["count"];
    description = json["description"];
    reference = json["reference"];
    content = json["content"];
  }
}