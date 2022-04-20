import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/auth/auth_cubit.dart';
import 'package:healthy_san/ui/login/login_screen.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/routes.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthUnAuthenticated) {
            return Container(
              margin: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Kamu harus login terlebih dahulu'),
                  SizedBox(height: 8,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, rLogin);
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      primary: BaseColor.base,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is AuthAuthenticated) {
            return ProfileBody();
          }
          return Container();
        },
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BaseColor.base,
        title: Text('Profil',style: TextStyle(color: BaseColor.darkGreen,)),
        actions: [
          InkWell(
            onTap: (){},
            child: Row(
              children: [
                Text('Keluar',style: TextStyle(color: BaseColor.darkGreen),),
                SizedBox(width: 4,),
                Icon(Icons.logout,color: BaseColor.darkGreen,),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage('https://asset.kompas.com/crops/ncgvDkq11ovx_624dxbv483x_iY=/0x0:648x432/750x500/data/photo/2021/10/05/615c371c61b81.jpg'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Text('Renna Nur Injiyani',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
              Text('rennaur@gmail.com'),
              SizedBox(height: 8,),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4,horizontal: 8,
                  ),
                  child: Text('Edit Profil',style: TextStyle(color: BaseColor.base,fontWeight: FontWeight.bold,)),
                  decoration: BoxDecoration(
                    color: BaseColor.lightGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Align(
                child: Text('Artikel favorit',style: TextStyle(fontWeight: FontWeight.bold)),
                alignment: Alignment.topLeft,
              ),
              ListView.separated(
                separatorBuilder: (context,i)=>Divider(),
                itemCount: 4,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,i){
                  return ListTile(
                    leading: Image.network('https://asset.kompas.com/crops/1y4AYAV9kzrAARMP-IpF_CdWKE4=/0x0:0x0/750x500/data/photo/2020/10/24/5f93dccf663f5.jpg',fit: BoxFit.cover),
                    title: Text('Manfaat Daun Pepaya Ampuh Benget, Penyakit Kronis Rontok'),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite,color: Colors.red),
                      onPressed: (){},
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

