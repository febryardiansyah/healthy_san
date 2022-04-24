import 'package:intl/intl.dart';

class Helpers{
  static String convertDate(DateTime date){
    return DateFormat('dd-MMM-yyyy').format(date);
  }
}