import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:hive/hive.dart';

// تأكد من أنك حصلت على uid الخاص بالمستخدم بعد تسجيل الدخول
Future<void> syncData() async {
  String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

  List<Add_data> dataList = await getDataFromHive();
  
  if (dataList.isEmpty) {
    print("No data found in Hive to upload.");
    return; // إنهاء العملية إذا لم توجد بيانات
  }
  
  try {
    await uploadDataToFirebase(dataList, currentUserUid);
  } catch (e) {
    print("Error during syncing data: $e");
  }
}

Future<List<Add_data>> getDataFromHive() async {
  Box<Add_data> box = await Hive.openBox<Add_data>('data');
  return box.values.toList();
}

Future<void> uploadDataToFirebase(List<Add_data> dataList, String? uid) async {
  if (uid == null) {
    print("User UID is null. Cannot upload data.");
    return;
  }

  // الوصول إلى المستند المحدد داخل مجموعة 'USERSSS'
  DocumentReference userDoc = FirebaseFirestore.instance.collection('USERSSS').doc(uid);

  // الحصول على البيانات الحالية
  DocumentSnapshot snapshot = await userDoc.get();
Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?; // تحويل إلى خريطة
List<dynamic> existingData = data?['transactions'] ?? []; // الحصول على البيانات الموجودة أو مصفوفة فارغة
  for (Add_data data in dataList) {
    try {
      existingData.add({
        'name': data.name,
        'datetime': data.datatime.toIso8601String(), // تحويل التاريخ إلى نص
        'amount': data.amount,
        'IN': data.IN,
      });
    } catch (e) {
      print("Error processing data: $e");
    }
  }

  // تحديث المستند بالبيانات الجديدة
  try {
    await userDoc.set({
      'transactions': existingData,
    }, SetOptions(merge: true)); // استخدام merge لتحديث المستند بدلاً من الكتابة فوقه
  } catch (e) {
    print("Error uploading data to Firebase: $e");
  }
}



