import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/newsClass.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tip {
  final String title;
  final String description;

  Tip({required this.title, required this.description});
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>> futureArticles;
  final String apiKey =
      'REPLACE_WITH_YOUR_SECRET'; 
  List<Article> allArticles = [];
  List<Article> filteredArticles = [];
  int currentPage = 1;
  final int pageSize = 20;

  List<Tip> tips = [
    Tip(
        title: 'استثمر في ما تفهمه',
        description:
            'لا تستثمر في شيء لا تفهمه. المعرفة هي القوة. - وارن بافيت'),
    Tip(
        title: 'تنويع المحفظة',
        description:
            'لا تضع كل بيضك في سلة واحدة. تنويع الاستثمارات يمكن أن يقلل المخاطر. - بيتر لينش'),
    Tip(
        title: 'الاستثمار على المدى الطويل',
        description:
            'استثمر على المدى الطويل ولا تدع تقلبات السوق اليومية تؤثر على قراراتك. - جون بوجل'),
    Tip(
        title: 'تحليل البيانات',
        description:
            'استخدم البيانات والتحليل لاتخاذ قرارات استثمارية. لا تعتمد على العواطف. - راي داليو'),
    Tip(
        title: 'الصبر والالتزام',
        description:
            'الصبر هو مفتاح النجاح في الاستثمار. الالتزام بخطتك هو ما يجعلك ناجحًا. - تشارلي مانجر'),
    Tip(
        title: 'تجنب الشائعات',
        description:
            'تجنب اتخاذ القرارات بناءً على الشائعات أو الأخبار غير المؤكدة. - كريس سميث'),
    Tip(
        title: 'تعلم من الأخطاء',
        description:
            'كل مستثمر يرتكب أخطاء. الأهم هو أن تتعلم منها ولا تكررها. - جيف بيزوس'),
  ];

  @override
  void initState() {
    super.initState();
    loadMoreArticles();
  }

  void loadMoreArticles() {
    futureArticles =
        fetchArticles(apiKey, pageSize: pageSize, page: currentPage)
            .then((articles) {
      setState(() {
        allArticles.addAll(articles);
        filteredArticles = allArticles;
      });
      return articles;
    });
  }

  Future<List<Article>> fetchArticles(String apiKey,
      {int pageSize = 20, int page = 1}) async {
  final response = await http.get(Uri.parse(
    'https://newsapi.org/v2/everything?q=investors OR dollar OR euro&apiKey=$apiKey&pageSize=$pageSize&page=$page'));
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

  void filterArticles(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredArticles = allArticles;
      });
    } else {
      setState(() {
        filteredArticles = allArticles.where((article) {
          return article.title.toLowerCase().contains(query.toLowerCase()) ||
              article.description.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  void showTipsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('نصائح للمستثمرين'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: tips.length,
              itemBuilder: (context, index) {
                final tip = tips[index];
                return ListTile(
                  title: Text(tip.title),
                  subtitle: Text(tip.description),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            tooltip: 'نصائح للمستثمرين',
            onPressed: () {
              showTipsDialog(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'أخبار العملات والمستثمرين ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];
                      return Card(
                        elevation: 4,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  article.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(article.source),
                                    if (article.publishedAt != null)
                                      Text(
                                        "${article.publishedAt!.day}/${article.publishedAt!.month}/${article.publishedAt!.year}",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                  ],
                                ),
                              ),
                              if (article.imageUrl != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    article.imageUrl!,
                                    fit: BoxFit.cover,
                                    height: 180,
                                    width: double.infinity,
                                  ),
                                ),
                              if (article.videoUrl != null)
                                Container(
                                  height: 200,
                                  child: VideoPlayer(
                                    VideoPlayerController.network(
                                        article.videoUrl!)
                                      ..initialize().then((_) {
                                        setState(() {});
                                      }),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentPage = 1;
            loadMoreArticles();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
