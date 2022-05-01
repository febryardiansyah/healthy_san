import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:healthy_san/bloc/get_new_article/get_new_article_cubit.dart';
import 'package:healthy_san/utils/styles.dart';

import '../../../utils/base_color.dart';
import '../../../utils/routes.dart';

class HomeNewest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewArticleCubit, GetNewArticleState>(
      builder: (context, state) {
        if (state is GetNewArticleLoading) {
          return Center(child: CupertinoActivityIndicator(),);
        }
        if (state is GetNewArticleFailure) {
          return Center(child: Text(state.msg),);
        }
        if (state is GetNewArticleSuccess) {
          final data = state.data;
          return Column(
            children: [
              Row(
                children: [
                  Text('Terbaru',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Lihat semua',
                          style: TextStyle(color: BaseColor.darkGreen),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: BaseColor.darkGreen,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              ListView.builder(
                itemCount: data.length > 5?data.getRange(0, 5).length:data.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,i){
                  final item = data[i];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, rDetailArticle,arguments: item.id);
                      },
                      child: Container(
                        height: 110,
                        padding: EdgeInsets.all(4),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: BaseColor.white,
                          boxShadow: boxShadow,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: BaseColor.base,),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(item.imageUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title!,style: TextStyle(fontWeight: FontWeight.bold,)),
                                  Html(data: item.desc!.length > 20?item.desc!.substring(0,20):item.desc!),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
