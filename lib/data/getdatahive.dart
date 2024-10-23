import 'package:hive_flutter/hive_flutter.dart';
part 'getdatahive.g.dart'; 

@HiveType(typeId: 1)
class Add_data extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String explain;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String IN;
  @HiveField(4)
  DateTime datatime;
  Add_data(this.name, this.explain, this.amount, this.IN, this.datatime);
}
