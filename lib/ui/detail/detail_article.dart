import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:healthy_san/bloc/add_to_favorite/add_to_favorite_cubit.dart';
import 'package:healthy_san/bloc/check_is_favorite/check_is_favorite_cubit.dart';
import 'package:healthy_san/bloc/get_detail_article/get_detail_article_cubit.dart';
import 'package:healthy_san/models/article_model.dart';
import 'package:healthy_san/utils/my_snackbar.dart';
import 'package:healthy_san/widgets/my_back_button.dart';

import '../../utils/base_color.dart';
import '../../utils/helpers.dart';

class DetailArticleScreen extends StatefulWidget {
  final String id;

  const DetailArticleScreen({Key? key,required this.id}) : super(key: key);

  @override
  _DetailArticleScreenState createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  late ArticleModel article;

  @override
  void initState() {
    super.initState();
    context.read<GetDetailArticleCubit>().fetchArticles(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AddToFavoriteCubit, AddToFavoriteState>(
          listener: (context, state) {
            if (state is AddToFavoriteLoading) {
              loadingSnackBar(context);
            }
            if (state is AddToFavoriteFailure) {
              failureSnackBar(context, state.msg);
            }
            if (state is AddToFavoriteSuccess) {
              successSnackBar(context, state.msg);
              context.read<CheckIsFavoriteCubit>().isFavorite(article);
            }
          },
          child: BlocConsumer<GetDetailArticleCubit, GetDetailArticleState>(
            listener: (context,state){
              if (state is GetDetailArticleSuccess) {
                setState(() {
                  article = state.data;
                });
                context.read<CheckIsFavoriteCubit>().isFavorite(state.data);
              }
            },
            builder: (context, state) {
              if (state is GetDetailArticleLoading) {
                return Center(child: CupertinoActivityIndicator(),);
              }
              if (state is GetDetailArticleFailure) {
                return Center(child: Text(state.msg),);
              }
              if (state is GetDetailArticleSuccess) {
                final data = state.data;
                return Stack(
                  children: [
                    data.imageUrl!.startsWith('data:image/')?Image.memory(
                      Helpers.convertBase64Image(data.imageUrl!,),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ):Image.network(data.imageUrl!,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      child: Row(
                        children: [
                          MyBackButton(),
                          Spacer(),
                          BlocBuilder<CheckIsFavoriteCubit, CheckIsFavoriteState>(
                            builder: (context, state) {
                              if (state is CheckIsFavoriteSuccess) {
                                final value = state.value;
                                return InkWell(
                                  onTap: (){
                                    context.read<AddToFavoriteCubit>().addToFav(data,value);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: value?Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ): Icon(Icons.favorite_border,color: BaseColor.white),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: BaseColor.black.withOpacity(0.2),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                    DraggableScrollableSheet(
                      minChildSize: 0.6,
                      maxChildSize: 1,
                      initialChildSize: 0.6,
                      builder: (context,scroll){
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: BaseColor.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )
                          ),
                          child: SingleChildScrollView(
                            controller: scroll,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${data.title}',textAlign: TextAlign.start,style: TextStyle(
                                    color: BaseColor.black,fontWeight: FontWeight.bold,fontSize: 24
                                ),),
                                Divider(),
                                Html(data: data.desc)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
