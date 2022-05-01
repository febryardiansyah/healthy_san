import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/auth/auth_cubit.dart';
import 'package:healthy_san/bloc/get_new_article/get_new_article_cubit.dart';
import 'package:healthy_san/bloc/get_popular_article/get_popular_article_cubit.dart';
import 'package:healthy_san/bloc/get_profile/get_profile_cubit.dart';
import 'package:healthy_san/ui/home/widget/home_newest.dart';
import 'package:healthy_san/ui/home/widget/home_popular.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/widgets/my_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkLogin();
    context.read<GetPopularArticleCubit>().fetchArticles();
    context.read<GetNewArticleCubit>().fetchArticles();
  }
  
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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthAuthenticated) {
                          return _BuildName();
                        }
                        if (state is AuthUnAuthenticated) {
                          return Text('di Healthy.San',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: BaseColor.darkGreen));
                        }
                        return Container();
                      },
                    )
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
      ),),
    );
  }
}

class _BuildName extends StatefulWidget {
  const _BuildName({Key? key}) : super(key: key);

  @override
  _BuildNameState createState() => _BuildNameState();
}

class _BuildNameState extends State<_BuildName> {
  @override
  void initState() {
    super.initState();
    context.read<GetProfileCubit>().fetchProfile();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileCubit, GetProfileState>(
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          return Text(state.user.name!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: BaseColor.darkGreen));
        }
        return Text('');
      },
    );
  }
}

