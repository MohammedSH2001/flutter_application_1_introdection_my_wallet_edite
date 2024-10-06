import 'package:flutter_application_1_introdection_my_wallet/data/data_transaction.dart';

List<money> geter() {
  money upwork = money();
  upwork.image = 'assets/card.png';
  upwork.name = 'upwork';
  upwork.fee = '\$ 650';
  upwork.time = 'today';
  upwork.buy = false;
  money secondTR = money();

  secondTR.buy = true;
  secondTR.fee = '\$ 450';
  secondTR.image = 'assets/Transportation.png';
  secondTR.name = 'vsi';
  secondTR.time = 'Yesterday';

  money threeTR = money();
  threeTR.buy = false;
  threeTR.fee = '\$ 150';
  threeTR.image = 'assets/food.png';
  threeTR.name = 'up';
  threeTR.time = 'Yesterday';

  money fore = money();
  fore.buy = true;
  fore.fee = '\$ 89';
  fore.image = 'assets/Education.png';
  fore.name = 'cardtop';
  fore.time = 'jun 30,2024';

  money upwork_2 = money();
  upwork_2.image = 'assets/card.png';
  upwork_2.name = 'upwork';
  upwork_2.fee = '\$ 650';
  upwork_2.time = 'today';
  upwork_2.buy = false;
  money secondTR_2 = money();
  
  secondTR_2.buy = true;
  secondTR_2.fee = '\$ 450';
  secondTR_2.image = 'assets/Transportation.png';
  secondTR_2.name = 'vsi';
  secondTR_2.time = 'Yesterday';

  money threeTR_2 = money();
  threeTR_2.buy = false;
  threeTR_2.fee = '\$ 150';
  threeTR_2.image = 'assets/food.png';
  threeTR_2.name = 'up';
  threeTR_2.time = 'Yesterday';

  money fore_2 = money();
  fore_2.buy = true;
  fore_2.fee = '\$ 89';
  fore_2.image = 'assets/Education.png';
  fore_2.name = 'cardtop';
  fore_2.time = 'jun 30,2024';


  return [upwork, secondTR, threeTR,fore,upwork_2,secondTR_2,threeTR_2,fore_2];
}
