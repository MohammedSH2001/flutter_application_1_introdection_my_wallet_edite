import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchDataScreen extends StatefulWidget {
  @override
  _FetchDataScreenState createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  String? currentUserUid; // معرف المستخدم

  late DocumentReference userDocument; // مرجع المستند

  @override
  void initState() {
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser?.uid; // تعيين معرف المستخدم

    if (currentUserUid != null) {
      userDocument = FirebaseFirestore.instance.collection('USERSSS').doc(currentUserUid); // تعيين مرجع المستند
      print('Current User UID: $currentUserUid');
    } else {
      print('No user is signed in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.background,

        title: Text('Firestore Data for User ${currentUserUid ?? "Unknown User"}'),
      ),
      body: currentUserUid == null
          ? Center(child: Text('No user is signed in. Please log in.'))
          : StreamBuilder<DocumentSnapshot>(
              stream: userDocument.snapshots(), // استخدام StreamBuilder لجلب بيانات المستند
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('No data available for this user.'));
                }

                final item = snapshot.data!.data() as Map<String, dynamic>;

                // تأكد من وجود حقل المعاملات
                if (item['transactions'] == null || !(item['transactions'] is List)) {
                  return Center(child: Text('No transactions available for this user.'));
                }

                // الحصول على قائمة المعاملات
                final transactions = item['transactions'] as List;

                // إذا كانت المعاملات فارغة
                if (transactions.isEmpty) {
                  return Center(child: Text('No transactions available.'));
                }

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index] as Map<String, dynamic>;

                    // الحصول على القيم المطلوبة من كل معاملة
                    final String imageName = transaction['name'] ?? 'food';
                    final double amount = double.tryParse(transaction['amount']?.toString() ?? '') ?? 0.0;
                    final String transactionType = transaction['IN'] ?? 'Unknown';

                    // تجاهل المعاملات التي تحتوي على 0.0
                    if (amount == 0.0) {
                      return SizedBox.shrink(); // تجاهل المعاملة
                    }

                    // تحويل التاريخ من String إلى DateTime
                    DateTime? date;
                    if (transaction['datetime'] is String) {
                      date = DateTime.tryParse(transaction['datetime']);
                    }

                    // تحديد لون السعر بناءً على نوع المعاملة
                    Color amountColor;
                    if (transactionType == 'Income') {
                      amountColor = Colors.green; // إذا كانت إضافة
                    } else if (transactionType == 'Expand') {
                      amountColor = Colors.red; // إذا كانت خصم
                    } else {
                      amountColor = Colors.black; // إذا لم يكن هناك نوع معروف
                    }

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/$imageName.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount: \$${amount.toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: amountColor),
                                ),
                                if (date != null)
                                  Text(
                                    'Date: ${date.year}-${date.month}-${date.day}',
                                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                  )
                                else
                                  Text(
                                    'Date: Not available',
                                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                  ),
                                SizedBox(height: 4), // مساحة بين النصوص
                                Text(
                                  'Type: $transactionType', // عرض نوع المعاملة
                                  style: TextStyle(fontSize: 16, color: Colors.teal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
