import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:hive/hive.dart';

Future<void> syncData() async {
  String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

  List<Add_data> dataList = await getDataFromHive();
  
  if (dataList.isEmpty) {
    print("No data found in Hive to upload.");
    return; 
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

  DocumentReference userDoc = FirebaseFirestore.instance.collection('USERSSS').doc(uid);

  DocumentSnapshot snapshot = await userDoc.get();
Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?; 
List<dynamic> existingData = data?['transactions'] ?? []; 
  for (Add_data data in dataList) {
    try {
      existingData.add({
        'name': data.name,
        'datetime': data.datatime.toIso8601String(), 
        'amount': data.amount,
        'IN': data.IN,
      });
    } catch (e) {
      print("Error processing data: $e");
    }
  }

  try {
    await userDoc.set({
      'transactions': existingData,
    }, SetOptions(merge: true)); 
  } catch (e) {
    print("Error uploading data to Firebase: $e");
  }
}



