import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/get_all_forums/get_all_forums_cubit.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/helpers.dart';
import 'package:healthy_san/utils/routes.dart';
import 'package:healthy_san/utils/styles.dart';

class ForYouScreen extends StatefulWidget {
  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllForumsCubit>().fetchAllForum();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<GetAllForumsCubit, GetAllForumsState>(
        builder: (context, state) {
          if (state is GetAllForumsLoading) {
            return Center(child: CupertinoActivityIndicator(),);
          }
          if (state is GetAllForumsFailure) {
            return Center(child: Text(state.msg),);
          }
          if (state is GetAllForumsSuccess) {
            final data = state.data;
            return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context,i){
                final item = data[i];
                return data.isEmpty?Center(
                  child: Text('Masih Kosong',style: TextStyle(color: BaseColor.base)),
                ): InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, rDetailForum,arguments: item.post?.id);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1,color: BaseColor.base),
                      boxShadow: boxShadow,
                      color: BaseColor.white,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(item.user!.profilePic!),
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              SizedBox(width: 4,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.user!.name!,style: TextStyle(fontWeight: FontWeight.bold,)),
                                  Text(Helpers.convertDate(item.post!.createdAt!)),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 8,),
                        Text(item.post!.question!),
                        SizedBox(height: 8,),
                        Divider(
                          color: BaseColor.base,
                        ),
                        Text('${item.post!.totalAnswer!} Jawaban',style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
