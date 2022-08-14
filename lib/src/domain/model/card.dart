class CardModel {
  final String title;
  final String message;
  final String from;
  final String asset;
  final DateTime date;

  CardModel({required this.title, required this.from, required this.message, required this.date, required this.asset});

  factory CardModel.fromMap(Map<String, dynamic> json) {
    return CardModel(
        date: DateTime.parse(json['date']), title: json['title'], from: json['from'], message: json['message'], asset: json['asset']);
  }

  Map<String, String> toMap() => {'title': title, 'asset': asset, 'from': from, 'message': message, 'date': date.toIso8601String()};
}
