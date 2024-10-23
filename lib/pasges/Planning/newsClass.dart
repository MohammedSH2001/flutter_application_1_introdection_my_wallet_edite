import 'dart:convert';
import 'package:http/http.dart' as http;
class Article {
  final String title;
  final String description;
  final String url;
  final String source;
  final String? imageUrl;
  final String? videoUrl;
  final DateTime? publishedAt; // تاريخ النشر

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    this.imageUrl,
    this.videoUrl,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      source: json['source']?['name'] ?? 'Unknown Source',
      imageUrl: json['urlToImage'],
      videoUrl: null, // يمكن إضافة منطق للحصول على مقاطع الفيديو إذا كانت متاحة
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt']) // تحويل السلسلة إلى DateTime
          : null,
    );
  }
}
Future<List<Article>> fetchArticles(String apiKey, {int pageSize = 20, int page = 1}) async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=cryptocurrency OR bitcoin OR ethereum OR altcoins OR blockchain&apiKey=$apiKey&pageSize=$pageSize&page=$page'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    List<Article> articles = [];
    for (var article in jsonData['articles']) {
      articles.add(Article.fromJson(article));
    }
    return articles;
  } else {
    throw Exception('Failed to load articles');
  }
}

