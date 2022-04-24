import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/get_my_post/get_my_post_cubit.dart';

import '../../bloc/get_all_forums/get_all_forums_cubit.dart';

class MyPostScreen extends StatefulWidget {
  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMyPostCubit>().fetchMyPost();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<GetMyPostCubit, GetMyPostState>(
        builder: (context, state) {
          if (state is GetMyPostLoading) {
            return Center(child: CupertinoActivityIndicator(),);
          }
          if (state is GetMyPostFailure) {
            return Center(child: Text(state.msg),);
          }
          if (state is GetMyPostSuccess) {
            return ListView.separated(
              itemCount: state.data.length,
              separatorBuilder: (context,i)=>Divider(),
              itemBuilder: (context,i){
                final item = state.data[i];
                return Card(
                  child: ListTile(
                    title: Text(item.post!.question!),
                    subtitle: Text('${item.post?.answerIds?.length} Jawaban'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: (){},
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
