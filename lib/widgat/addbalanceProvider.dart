import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/balanceMy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Increment with ChangeNotifier {
  double myNumber = 0;
  SharedPreferencesAsync pref = SharedPreferencesAsync();

  add(int AddBalance)async {
    
    myNumber = myNumber + AddBalance;
    notifyListeners();
                await  pref.setInt("addMybalance", myNumber as int);

  }
}
