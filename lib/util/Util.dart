import 'package:intl/intl.dart';

class Util{

  static String convertDateToString(DateTime date,String format){
    return DateFormat(format).format(date);
  }

}