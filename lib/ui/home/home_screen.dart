import 'package:flutter/material.dart';
import 'package:healthy_san/ui/home/widget/home_newest.dart';
import 'package:healthy_san/ui/home/widget/home_popular.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/widgets/my_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: BaseColor.base,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat datang,',style: TextStyle(color: BaseColor.darkGreen)),
                      Text('Renna Nur Injiyani',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: BaseColor.darkGreen)),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: BaseColor.darkGreen,)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyForm(
                    hintText: 'Cari artikel disini',
                    prefixIcon: Icon(Icons.search),
                  ),
                  SizedBox(height: 12,),
                  HomePopular(),
                  SizedBox(height: 12,),
                  HomeNewest(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
