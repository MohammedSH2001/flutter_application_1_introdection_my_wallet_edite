import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/database.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';
import 'package:flutter_application_1_introdection_my_wallet/pasges/Planning/QRcodeMy.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddScreenMy extends StatefulWidget {
  const AddScreenMy({super.key});

  @override
  State<AddScreenMy> createState() => _AddScreenMyState();
}

class _AddScreenMyState extends State<AddScreenMy> {
  final box = Hive.box<Add_data>("data");
  DateTime date = new DateTime.now();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  String? selectitem;
  String? selectitemi;

  final userrr = FirebaseAuth.instance.currentUser!;

  FocusNode ex = FocusNode();
  final TextEditingController expalinn_c = TextEditingController();
  FocusNode amount = FocusNode();
  final TextEditingController amount_c = TextEditingController();
  final List<String> _item = [
    "food",
    "Transfer",
    "card",
    "Education",
    "Transportation",
    "Tes",
    "gift",
    "shop",
    "pay",
    "gaming",
    "health",
    "family",
    "maintenance",
    "other"
  ];
  final List<String> _itemi = [
    "Income",
    "Expand",
  ];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    ex.addListener(() {
      setState(() {});
    });
    amount.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _databaseHelper.initDatabase();
  }

  File? _image;

  // Future<void> downloadModel() async {
  //   FirebaseCustomModel model = await FirebaseModelDownloader.instance.getModel(
  //     "my_model",
  //     FirebaseModelDownloadType
  //         .latestModel, // يمكنك تغيير نوع التحميل حسب احتياجاتك
  //     FirebaseModelDownloadConditions(
  //       iosAllowsCellularAccess: true,
  //       androidChargingRequired: false,
  //     ),
  //   );

  //   // يمكنك الآن الوصول إلى النموذج
  //   final modelFile = model.file;
  //   print("Model path: ${modelFile.path}");
  // }

  Future<void> _pickImage() async {
    // طلب الأذونات
    // var status = await Permission.camera.request();
    // if (status.isGranted) {
    //   final picker = ImagePicker();
    //   final pickedFile = await picker.pickImage(source: ImageSource.camera);

    //   if (pickedFile != null) {
    //     setState(() {
    //       _image = File(pickedFile.path);
    //     });
    //   } else {
    //     Get.snackbar("Error", "No image selected");
    //   }
    // } else {
    //   Get.snackbar("Error", "Camera permission denied");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            background_Continar(context),
            Positioned(
              top: 120,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                    // color: Theme.of(context).colorScheme.primary,
                    ,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  height: 550,
                  width: 340,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      name(),
                      SizedBox(
                        height: 30,
                      ),
                      explian(),
                      SizedBox(
                        height: 30,
                      ),
                      amount_(),
                      SizedBox(
                        height: 30,
                      ),
                      How(),
                      SizedBox(
                        height: 30,
                      ),
                      Date_Time(context),
                      Spacer(),
                      save(),
                      SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column background_Continar(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 111,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Adding",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 23, 107, 135)),
                    ),
                    IconButton(
                      onPressed: () {
                        // downloadModel();
                        QRViewExample();
                      },
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        var add = Add_data(
            selectitem!, expalinn_c.text, amount_c.text, selectitemi!, date);
        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 23, 107, 135),
        ),
        width: 120,
        height: 50,
        child: Text(
          "Save",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget Date_Time(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Color(0xffC5C5C5),
        ),
      ),
      width: 300,
      child: TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100));
            if (newDate == null) return;
            setState(() {
              date = newDate;
            });
          },
          child: Text(
            "Date  :  ${date.year} / ${date.day} / ${date.month}",
            style: TextStyle(fontSize: 15, color: Colors.black),
          )),
    );
  }

  Padding How() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffc5c5c5),
          ),
        ),
        child: DropdownButton<String>(
            value: selectitemi,
            padding: EdgeInsets.symmetric(horizontal: 15),
            items: _itemi
                .map((e) => DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: Image.asset("assets/${e}.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      value: e,
                    ))
                .toList(),
            selectedItemBuilder: (BuildContext context) => _itemi
                .map((e) => Row(
                      children: [
                        Container(
                          width: 40,
                          child: Image.asset("assets/${e}.png"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ))
                .toList(),
            hint: Text("How"),
            dropdownColor: Colors.white,
            isExpanded: true,
            underline: Container(),
            onChanged: ((value) {
              setState(() {
                selectitemi = value!;
              });
            })),
      ),
    );
  }

  Padding amount_() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount,
        controller: amount_c,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: "amount",
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffc5c5c5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffc5c5c5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(255, 23, 107, 135),
            ),
          ),
        ),
      ),
    );
  }

  Padding explian() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: TextField(
        focusNode: ex,
        controller: expalinn_c,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: "explain",
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffc5c5c5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffc5c5c5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(255, 23, 107, 135),
            ),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffc5c5c5),
          ),
        ),
        child: DropdownButton<String>(
            value: selectitem,
            padding: EdgeInsets.symmetric(horizontal: 15),
            items: _item
                .map((e) => DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: Image.asset("assets/${e}.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      value: e,
                    ))
                .toList(),
            selectedItemBuilder: (BuildContext context) => _item
                .map((e) => Row(
                      children: [
                        Container(
                          width: 40,
                          child: Image.asset("assets/${e}.png"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ))
                .toList(),
            hint: Text("category"),
            dropdownColor: Theme.of(context).colorScheme.background,
            isExpanded: true,
            underline: Container(),
            onChanged: ((value) {
              setState(() {
                selectitem = value!;
              });
            })),
      ),
    );
  }
}
