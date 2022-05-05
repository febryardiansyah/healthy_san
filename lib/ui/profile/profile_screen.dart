import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/auth/auth_cubit.dart';
import 'package:healthy_san/bloc/get_favorites/get_favorites_cubit.dart';
import 'package:healthy_san/bloc/get_profile/get_profile_cubit.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/helpers.dart';
import 'package:healthy_san/utils/my_snackbar.dart';
import 'package:healthy_san/utils/routes.dart';

import '../../bloc/add_to_favorite/add_to_favorite_cubit.dart';

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
  void initState() {
    super.initState();
    context.read<GetProfileCubit>().fetchProfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BaseColor.base,
        title: Text('Profil',style: TextStyle(color: BaseColor.darkGreen,)),
        actions: [
          InkWell(
            onTap: (){
              context.read<AuthCubit>().loggedOut();
            },
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
      body: BlocListener<AddToFavoriteCubit, AddToFavoriteState>(
        listener: (context, state) {
          if (state is AddToFavoriteLoading) {
            loadingSnackBar(context);
          }
          if (state is AddToFavoriteFailure) {
            failureSnackBar(context, state.msg);
          }
          if (state is AddToFavoriteSuccess) {
            successSnackBar(context, state.msg);
            context.read<GetProfileCubit>().fetchProfile();
          }
        },
        child: BlocConsumer<GetProfileCubit, GetProfileState>(
          listener: (context, state) {
            if (state is GetProfileSuccess) {
              context.read<GetFavoritesCubit>().fetchFavorites(state.user.uid!);
            }
          },
          builder: (context, state) {
            if (state is GetProfileLoading) {
              return Center(child: CupertinoActivityIndicator(),);
            }
            if (state is GetProfileFailure) {
              return Center(child: Text(state.msg),);
            }
            if (state is GetProfileSuccess) {
              final user = state.user;
              return SingleChildScrollView(
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
                              image: NetworkImage(user.profilePic!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(user.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                      Text(user.email!),
                      SizedBox(height: 8,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, rEditProfile,arguments: user);
                        },
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
                      BlocBuilder<GetFavoritesCubit, GetFavoritesState>(
                        builder: (context, state) {
                          if (state is GetFavoritesLoading) {
                            return Center(child: CupertinoActivityIndicator(),);
                          }
                          if (state is GetFavoritesFailure) {
                            return Center(child: Text(state.msg),);
                          }
                          if (state is GetFavoritesSuccess) {
                            final data = state.data;
                            return ListView.separated(
                              separatorBuilder: (context,i)=>Divider(),
                              itemCount: data.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context,i){
                                final item = data[i];
                                return ListTile(
                                  onTap: (){
                                    Navigator.pushNamed(context, rDetailArticle,arguments: item.id);
                                  },
                                  leading: item.imageUrl!.startsWith('data:image/')?Image.memory(
                                    Helpers.convertBase64Image(item.imageUrl!),
                                    width: 60,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ):Image.network(item.imageUrl!,
                                    width: 60,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(item.title!),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete,color: Colors.red),
                                    onPressed: (){
                                      context.read<AddToFavoriteCubit>().addToFav(item,true);
                                    },
                                  ),
                                );
                              },
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

