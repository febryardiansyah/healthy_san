import 'package:flutter/material.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/routes.dart';
import 'package:healthy_san/widgets/my_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.close,color: BaseColor.grey),
                  ),
                ),
                SizedBox(height: 44,),
                Center(
                  child: Text('Masuk',style: TextStyle(color: BaseColor.base,fontSize: 26,fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 16,),
                Center(
                  child: Text('Masuk dengan akun yang pernah kamu buat untuk melanjutkan',
                    style: TextStyle(color: BaseColor.black,fontSize: 16,fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24,),
                Text('Alamat Email'),
                SizedBox(height: 8,),
                MyForm(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'mail@mail.com',
                ),
                SizedBox(height: 12,),
                Text('Kata Sandi'),
                SizedBox(height: 8,),
                MyForm(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'kata sandi',
                  secureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    onPressed: (){},
                  ),
                ),
                SizedBox(height: 24,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, rHome);
                  },
                  child: Text('Masuk'),
                  style: ElevatedButton.styleFrom(
                    primary: BaseColor.base,
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                ),
                SizedBox(height: 28,),
                Center(
                  child: InkWell(
                    onTap: ()=>Navigator.pushNamed(context, rRegister),
                    child: RichText(
                      text: TextSpan(
                        text: 'Belum punya akun? ',
                        style: TextStyle(color: BaseColor.black),
                        children: [
                          TextSpan(
                            text: 'Daftar Sekarang',
                            style: TextStyle(color: BaseColor.base,fontWeight: FontWeight.bold,)
                          )
                        ]
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
