import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/Planning_AI.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

final box = Hive.box<Add_data>('data');

class _BotScreenState extends State<BotScreen> {
  final TextEditingController _userMessage = TextEditingController();
  static const apiKey = "REPLACE_WITH_YOUR_SECRET";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<Message> _messages = [];

  bool initialDataSent = false;
  var getData = box.values.toList();

Map<String, double> analyzeData(List<Add_data> data) {
  Map<String, double> analysis = {};
  for (var item in data) {
    double amount = double.tryParse(item.amount.toString()) ?? 0.0; 

    analysis[item.name] = (analysis[item.name] ?? 0) + amount;
  }
  return analysis;
}

  Future<void> sendInitialMessage() async {
    if (!initialDataSent) {
      setState(() {
        _messages.add(Message(
          isuser: false,
          message:
              "مرحباً! أنا الذكاء الاصطناعي الخاص بك. لقد تحصلت على نفقاتك اليومية، انتظر قليلاً، سوف أعطيك نصيحة ربما تفيدك.",
          date: DateTime.now(),
        ));
      });

      var readableData = getData
          .map((it) =>
              ("amount: ${it.amount} - type: ${it.IN} - category: ${it.name} - date: ${it.datatime.toIso8601String()} - notes: ${it.explain}"))
          .toList();

      final response = await model.generateContent([
        Content.text("take a look at my expenses and give me some advice"),
        ...readableData.map((it) => Content.text(it))
      ]);

      setState(() {
        _messages.add(Message(
            isuser: false, message: response.text ?? "", date: DateTime.now()));
      });
      initialDataSent = true;
    }
  }

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();
    setState(() {
      _messages.add(Message(
          isuser: true, message: message, date: DateTime.now()));
    });

    var readableData = getData
        .map((it) =>
            ("amount: ${it.amount} - type: ${it.IN} - category: ${it.name} - date: ${it.datatime.toIso8601String()} - notes: ${it.explain}"))
        .toList();

    final response = await model.generateContent([
      Content.text(message),
      ...readableData.map((it) => Content.text(it))
    ]);

    setState(() {
      _messages.add(Message(
          isuser: false, message: response.text ?? "", date: DateTime.now()));
    });
  }

  @override
  void initState() {
    super.initState();
    sendInitialMessage();
  }


  

@override
Widget build(BuildContext context) {
  Map<String, double> analysis = analyzeData(getData); 
  return Scaffold(
    appBar: AppBar(
      title: const Text("Bot"),
      backgroundColor: Colors.teal,
      actions: [
        IconButton(
          icon: const Icon(Icons.analytics),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnalysisScreen(analysis: analysis),
              ),
            );
          },
        ),
      ],
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            itemBuilder: (context, index) {
              final message = _messages[index];
              return Messages(
                isuser: message.isuser,
                message: message.message,
                date: DateFormat('HH:mm').format(message.date),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _userMessage,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Ask Gemini...",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.teal),
                iconSize: 30,
                onPressed: sendMessage,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}


class Messages extends StatelessWidget {
  final bool isuser;
  final String message;
  final String date;

  const Messages(
      {super.key, required this.isuser, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isuser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isuser ? Colors.teal : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isuser ? const Radius.circular(20) : Radius.zero,
            bottomRight: isuser ? Radius.zero : const Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isuser ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(
                color: isuser ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final bool isuser;
  final String message;
  final DateTime date;

  Message({required this.isuser, required this.message, required this.date});
}
