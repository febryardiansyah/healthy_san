import 'package:flutter/material.dart';
import 'package:healthy_san/widgets/my_back_button.dart';

import '../../utils/base_color.dart';
import '../../widgets/my_form.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyBackButton(),
                SizedBox(
                  height: 44,
                ),
                Center(
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: BaseColor.base,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    'Silahkan lengkapi form untuk membuat akun baru',
                    style: TextStyle(
                      color: BaseColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text('Nama Lengkap'),
                SizedBox(
                  height: 8,
                ),
                MyForm(
                  keyboardType: TextInputType.text,
                  hintText: 'John Doe',
                ),
                Text('Alamat Email'),
                SizedBox(
                  height: 8,
                ),
                MyForm(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'mail@mail.com',
                ),
                SizedBox(
                  height: 12,
                ),
                Text('Kata Sandi'),
                SizedBox(
                  height: 8,
                ),
                MyForm(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'kata sandi',
                  secureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Daftar'),
                  style: ElevatedButton.styleFrom(
                    primary: BaseColor.base,
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
