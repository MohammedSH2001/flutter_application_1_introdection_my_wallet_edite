import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/planningMy.dart';
import 'package:flutter_application_1_introdection_my_wallet/widgat/Bottun.dart';

class MyAppPlanning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Exchange',
      debugShowCheckedModeBanner: false,
      home: CurrencyExchangeScreen(),
    );
  }
}

class CurrencyExchangeScreen extends StatefulWidget {
  @override
  _CurrencyExchangeScreenState createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  final String apiKey = 'DC4BPTSNBK44C472';
  late MarketDataService service;
  Map<String, dynamic>? exchangeRateDataToUSD;
  Map<String, dynamic>? exchangeRateDataToLYD;

  @override
  void initState() {
    super.initState();
    service = MarketDataService(apiKey);
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    try {
      exchangeRateDataToUSD = await service.fetchExchangeRate('LYD', 'USD');
      exchangeRateDataToLYD = await service.fetchExchangeRate('USD', 'LYD');
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currencies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottunMy()));
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: exchangeRateDataToUSD == null || exchangeRateDataToLYD == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text(
                    'LYD to USD',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  subtitle: Text(
                      '1 LYD = ${exchangeRateDataToUSD!['Realtime Currency Exchange Rate']['5. Exchange Rate']} USD',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                          color: Colors.grey)),
                ),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  title: Text('USD to LYD',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  subtitle: Text(
                    '1 USD = ${exchangeRateDataToLYD!['Realtime Currency Exchange Rate']['5. Exchange Rate']} LYD',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
    );
  }
}
