class SahihBukhariModels {
  final String title;
  final List<Page> pages;

  SahihBukhariModels({ required this.title, required this.pages});

  factory SahihBukhariModels.fromJson(Map<String, dynamic> json) {
    return SahihBukhariModels(
      title: json['title'],
      pages: (json['pages'] as List)
          .map((i) => Page.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Page {
  final String text;
  final String title;

  Page({ required this.text, required this.title});

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      text: json['text'],
      title: json['title'],
    );
  }
}
