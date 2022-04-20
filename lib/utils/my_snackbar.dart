import 'package:flutter/material.dart';

void loadingSnackBar(BuildContext context){
  ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Loading..')));
}
void failureSnackBar(BuildContext context,String message){
  ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,));
}

void successSnackBar(BuildContext context,String message){
  ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.blue,));
}