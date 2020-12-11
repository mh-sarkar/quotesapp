class QuoteModel {
  String text;
  String author;

  QuoteModel({this.text, this.author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return new QuoteModel(text: json['text'] as String, author: json['author'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['author'] = this.author;
    return data;
  }
}
