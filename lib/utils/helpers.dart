import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';

class Helpers{
  static String convertDate(DateTime date){
    return DateFormat('dd-MMM-yyyy').format(date);
  }
  static Uint8List convertBase64Image(String base64String) {
    return Base64Decoder().convert(base64String.split(',').last);
  }
}