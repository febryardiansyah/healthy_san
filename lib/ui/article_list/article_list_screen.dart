import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:healthy_san/bloc/get_article_list/get_article_list_cubit.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/helpers.dart';
import 'package:healthy_san/utils/routes.dart';

class ArticleListScreen extends StatefulWidget {
  final ArticleListParams params;

  const ArticleListScreen({Key? key,required this.params}) : super(key: key);
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  ArticleListParams get params => widget.params;

  @override
  void initState() {
    super.initState();
    context.read<GetArticleListCubit>().fetchArticles(
      isPopular: params.listType == ListType.popular,
      keyword: params.keywords,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel'),
        backgroundColor: BaseColor.base,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                child: Text(
                  params.listType == ListType.popular?'Popular':params.listType == ListType.newest?'Terbaru':params.keywords!,
                  style: TextStyle(color: BaseColor.base),
                ),
                decoration: BoxDecoration(
                  color: BaseColor.base.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 8,),
              BlocBuilder<GetArticleListCubit, GetArticleListState>(
                builder: (context, state) {
                  if (state is GetArticleListLoading) {
                    return Center(child: CupertinoActivityIndicator(),);
                  }
                  if (state is GetArticleListFailure) {
                    return Center(child: Text(state.msg),);
                  }
                  if (state is GetArticleListSuccess) {
                    final data = state.data;
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,i){
                        final item = data[i];
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, rDetailArticle,arguments: item.id);
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1,color: BaseColor.base),
                              color: BaseColor.white,
                            ),
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                item.imageUrl!.startsWith('data:image/')?Image.memory(
                                  Helpers.convertBase64Image(item.imageUrl!,),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ):Image.network(
                                  item.imageUrl!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title!,
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                                      ),
                                      SizedBox(height: 4,),
                                      Html(
                                        data: item.desc!.length > 30?'${item.desc!.substring(0,30)}..':item.desc!,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
      ),
    );
  }
}

class ArticleListParams{
  final ListType listType;
  final String? keywords;

  ArticleListParams({required this.listType, this.keywords});
}

enum ListType{
  popular,newest,search
}