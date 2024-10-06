import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/database.dart';

class AddScreenMy extends StatefulWidget {
  const AddScreenMy({super.key});

  @override
  State<AddScreenMy> createState() => _AddScreenMyState();
}

class _AddScreenMyState extends State<AddScreenMy> {
  DateTime date = new DateTime.now();
    final DatabaseHelper _databaseHelper = DatabaseHelper();


  String? selectitem;
  String? selectitemi;

  FocusNode ex = FocusNode();
  final TextEditingController expalinn_c = TextEditingController();
  FocusNode amount = FocusNode();
  final TextEditingController amount_c = TextEditingController();
  final List<String> _item = [
    "food",
    "Transfer",
    "card",
    "Education",
    "Transportation"
  ];
  final List<String> _itemi = ["Income", "Expand"];
   // متغيرات جديدة لتخزين البيانات المدخلة
  String _enteredName = '';
  String _enteredExplain = '';
  double _enteredAmount = 0.0;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [

          background_Continar(context),
          
          Positioned(
            top: 120,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
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
                  SizedBox(height: 20,),



                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            'Entered Data:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Name: $_enteredName'),
                          Text('Explain: $_enteredExplain'),
                          Text('Amount: $_enteredAmount'),
                          Text('Date: ${date.year} / ${date.day} / ${date.month}'),
                        ],
                      ),
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
                  
        

  Column background_Continar(BuildContext context) {
    return Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 3, 32, 149),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
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
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Adding",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.attach_email_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
  }


  
  GestureDetector save() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _enteredName = selectitem ?? 'No Title';
          _enteredExplain = expalinn_c.text;
          _enteredAmount = double.tryParse(amount_c.text) ?? 0.0;
        });

        await _databaseHelper.insertTransaction(
          selectitem ?? 'No Title',
          expalinn_c.text,
          double.tryParse(amount_c.text) ?? 0.0,
          date.toString(),
        );
        Navigator.of(context).pop(); 
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 3, 32, 149),
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
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              color: Color.fromARGB(255, 3, 32, 149),
            ),
          ),
        ),
      ),
    );
  }

  Padding explian() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              color: Color.fromARGB(255, 3, 32, 149),
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
            hint: Text("name"),
            dropdownColor: Colors.white,
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
