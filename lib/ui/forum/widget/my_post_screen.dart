import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/delete_post/delete_post_cubit.dart';
import 'package:healthy_san/bloc/get_my_post/get_my_post_cubit.dart';
import 'package:healthy_san/utils/my_snackbar.dart';

import '../../../bloc/get_all_forums/get_all_forums_cubit.dart';
import '../../../utils/routes.dart';

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
      child: BlocListener<DeletePostCubit, DeletePostState>(
        listener: (context, state) {
          if (state is DeletePostLoading) {
            loadingSnackBar(context);
          }
          if (state is DeletePostFailure) {
            failureSnackBar(context, state.msg);
          }
          if (state is DeletePostSuccess) {
            successSnackBar(context, state.msg);
            context.read<GetMyPostCubit>().fetchMyPost();
          }
        },
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
                separatorBuilder: (context, i) => Divider(),
                itemBuilder: (context, i) {
                  final item = state.data[i];
                  return Card(
                    child: ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, rDetailForum,arguments: item.post?.id);
                      },
                      title: Text(item.post!.question!),
                      subtitle: Text('${item.post?.totalAnswer} Jawaban'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                        onPressed: () {
                          context.read<DeletePostCubit>().delete(item.post!.id!);
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
