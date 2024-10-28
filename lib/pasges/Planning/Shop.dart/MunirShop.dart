import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/QRcodeMy.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MunirShop extends StatefulWidget {
  const MunirShop({super.key});

  @override
  State<MunirShop> createState() => _MunirShopState();
}

class _MunirShopState extends State<MunirShop> {
  // بيانات الفواتير
  final List<Map<String, dynamic>> invoices = [
    {'amount': 50.0, 'date': '2024-10-20'},
    {'amount': 30.0, 'date': '2024-10-21'},
    {'amount': 20.0, 'date': '2024-10-22'},
  ];

  double get totalAmount =>
      invoices.fold(0, (sum, invoice) => sum + invoice['amount'] as double);

  // بيانات الإعلانات
  final List<String> ads = [
    "assets/sale.jpg", // تأكد من إضافة الصور في مجلد assets
    "assets/sale_2.jpg",
    "assets/discount.jpg",
  ];

    // تهيئة مباشرة بدون استخدام late
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

@override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < ads.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "سوق منير",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              _buildAdBanner(), // إضافة مساحة الإعلان
              SizedBox(height: 20),
                 SizedBox(height: 10),
            _buildPageIndicator(),

              // _buildCard(
              //   context,
              //   title: "أفضل العروض",
              //   image: "assets/discount.jpg",
              //   onTap: () {},
              // ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconWithLabel(
                    icon: Icons.qr_code_scanner,
                    color: Colors.blue,
                    label: "QRcode",
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRCodeScannerPage()),
                      );
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("الكود الممسوح: $result")),
                        );
                      }
                    },
                  ),
                  SizedBox(width: 30),
                  _buildIconWithLabel(
                    icon: Icons.monetization_on,
                    color: Colors.amber,
                    label: "points",
                    onPressed: () => _showInvoicesDialog(context),
                  ),
                ],
              ),
              SizedBox(height: 25),
              _buildInfoCard(),
              SizedBox(height: 15),
              _buildTipsBox(),
              SizedBox(height: 15),
              _buildProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildAdBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 200,
        child: PageView.builder(
          controller: _pageController,
          itemCount: ads.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                ads[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: _pageController,
      count: ads.length,
      effect: ExpandingDotsEffect(
        activeDotColor: Colors.blue, 
        dotColor: Colors.grey,      
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 3,        
        spacing: 8,
      ),
    );
  }


  void _showInvoicesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Center(
              child: Text(
                "تفاصيل الفواتير",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...invoices.map((invoice) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.grey.shade200,
                        child: ListTile(
                          leading: Icon(
                            Icons.receipt_long,
                            color: Colors.blueAccent,
                          ),
                          title: Text(
                            "فاتورة بتاريخ: ${invoice['date']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "السعر: ${invoice['amount']} دينار",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  Divider(thickness: 1.5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.attach_money,
                        color: Colors.green,
                      ),
                      title: Text(
                        "إجمالي السعر",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "$totalAmount دينار",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.control_point_duplicate_sharp,
                        color: Colors.amber,
                      ),
                      title: Text(
                        "إجمالي النقاط",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "10 نقطه",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  if (totalAmount >=
                      100) 
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min, 
                          children: [
                            Icon(Icons.card_giftcard, color: Colors.orange),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "مبروك! حصلت على كوبون بقيمة 50 دينار 🎉",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade800,
                                ),
                                textAlign: TextAlign.center, // توسيط النص
                                overflow: TextOverflow
                                    .ellipsis, // إضافة ... إذا كان النص طويلًا جدًا
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "إغلاق",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required String image,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithLabel({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: 38,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(15),
          width: 350,
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.redAccent, size: 24),
                  SizedBox(width: 10),
                  Text(
                    "مصراتة، ليبيا",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.green, size: 24),
                  SizedBox(width: 10),
                  Text(
                    "+218 91 234 5678",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipsBox() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "هل تعلم؟ عند وصول إجمالي سعر فواتيرك إلى 1000 دينار، ستحصل على كوبون بقيمة 50 دينار!",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "قريب من هدفك!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey.shade300,
            color: Colors.blue,
            minHeight: 8,
          ),
          SizedBox(height: 5),
          Text(
            "نقاطك: 1200 / 2000",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
