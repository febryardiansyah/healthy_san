import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/login/login_cubit.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/my_snackbar.dart';
import 'package:healthy_san/utils/routes.dart';
import 'package:healthy_san/widgets/my_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEdc = TextEditingController();
  final passEdc = TextEditingController();
  bool passInvisible = true;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              loadingSnackBar(context);
            }
            if (state is LoginFailure) {
              failureSnackBar(context, state.msg);
            }
            if (state is LoginSuccess) {
              successSnackBar(context, state.msg);
            }
          },
          child: Padding(
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
                  controller: emailEdc,
                ),
                SizedBox(height: 12,),
                Text('Kata Sandi'),
                SizedBox(height: 8,),
                MyForm(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'kata sandi',
                  controller: passEdc,
                  secureText: passInvisible,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    onPressed: (){
                      setState(() {
                        passInvisible = !passInvisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 24,),
                ElevatedButton(
                  onPressed: (){
                    context.read<LoginCubit>().login(email: emailEdc.text, password: passEdc.text);
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
      ),
    );
  }
}
