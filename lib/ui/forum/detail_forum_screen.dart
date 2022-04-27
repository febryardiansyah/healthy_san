import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/get_answers/get_answers_cubit.dart';
import 'package:healthy_san/bloc/get_detail_post/get_detail_post_cubit.dart';
import 'package:healthy_san/bloc/post_answer/post_answer_cubit.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/helpers.dart';
import 'package:healthy_san/utils/my_snackbar.dart';
import 'package:healthy_san/widgets/my_back_button.dart';
import 'package:healthy_san/widgets/my_form.dart';

class DetailForumScreen extends StatefulWidget {
  final String id;

  const DetailForumScreen({Key? key,required this.id}) : super(key: key);
  @override
  _DetailForumScreenState createState() => _DetailForumScreenState();
}

class _DetailForumScreenState extends State<DetailForumScreen> {
  final textEDC = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    context.read<GetDetailPostCubit>().fetchDetailPost(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    print('Bottom => ${MediaQuery.of(context).viewInsets.bottom}');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.transparent,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<PostAnswerCubit, PostAnswerState>(
              listener: (context, state) {
                if (state is PostAnswerLoading) {
                  loadingSnackBar(context);
                }
                if (state is PostAnswerFailure) {
                  failureSnackBar(context, state.msg);
                }
                if (state is PostAnswerSuccess) {
                  textEDC.clear();
                  successSnackBar(context, state.msg);
                  context.read<GetDetailPostCubit>().fetchDetailPost(widget.id);
                }
              },
            ),
            BlocListener<GetDetailPostCubit, GetDetailPostState>(
              listener: (context, state) {
                if (state is GetDetailPostSuccess) {
                  context.read<GetAnswersCubit>().fetchAnswers(widget.id);
                }
              },
            ),
          ],
          child: BlocBuilder<GetDetailPostCubit, GetDetailPostState>(
            builder: (context, state) {
              if (state is GetDetailPostLoading) {
                return Center(child: CupertinoActivityIndicator(),);
              }
              if (state is GetDetailPostFailure) {
                return Center(child: Text(state.msg),);
              }
              if (state is GetDetailPostSuccess) {
                final user = state.data.user!;
                final post = state.data.post!;
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: BaseColor.base.withOpacity(0.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Image.network(user.profilePic!,
                                            width: 50,height: 50,fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 8,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${user.name}',style: TextStyle(fontWeight: FontWeight.bold),),
                                              SizedBox(height: 4,),
                                              Text(Helpers.convertDate(post.createdAt!)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Text(post.question!)
                                  ],
                                ),
                              ),
                              BlocBuilder<GetAnswersCubit, GetAnswersState>(
                                builder: (context, state) {
                                  if (state is GetAnswersSuccess) {
                                    final data = state.data;
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16,),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: BaseColor.grey.withOpacity(0.5),
                                          ),
                                          child: IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                Icon(Icons.comment),
                                                SizedBox(width: 4,),
                                                Text('${data.length} Total Jawaban')
                                              ],
                                            ),
                                          ),
                                        ),
                                        ListView.separated(
                                          separatorBuilder: (context, index) => Divider(),
                                          itemCount: data.length,
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemBuilder: (context,i){
                                            final item = data[i];
                                            return ListTile(
                                              leading: Image.network(item.user.profilePic!, width: 30,height: 30,fit: BoxFit.cover),
                                              title: Text('${item.user.name}'),
                                              subtitle: Text('${item.answer.answer}'),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                  return Container();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          color: BaseColor.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: MyForm(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  textCapitalization: TextCapitalization.sentences,
                                  hintText: 'Tambah jawaban..',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  borderRadius: 8,
                                  controller: textEDC,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4,),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    if (textEDC.text.isNotEmpty) {
                                      context.read<PostAnswerCubit>().postAnswer(post.id!, textEDC.text);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                        Icons.add, color: BaseColor.white),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: BaseColor.base,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
