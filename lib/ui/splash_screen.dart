import 'package:flutter/material.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushNamedAndRemoveUntil(context, rLogin, (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.base,
      body: Center(
        child: Text('Healthy.San',style: TextStyle(
          color: BaseColor.white,fontSize: 44,fontWeight: FontWeight.bold,
        )),
      ),
    );
  }
}
