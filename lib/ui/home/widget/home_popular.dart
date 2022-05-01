import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_san/bloc/get_popular_article/get_popular_article_cubit.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/routes.dart';
import 'package:healthy_san/utils/styles.dart';

class HomePopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPopularArticleCubit, GetPopularArticleState>(
      builder: (context, state) {
        if (state is GetPopularArticleLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is GetPopularArticleFailure) {
          return Center(
            child: Text(state.msg),
          );
        }
        if (state is GetPopularArticleSuccess) {
          final data = state.data;
          return Column(
            children: [
              Row(
                children: [
                  Text('Paling Popular',
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
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length > 5 ?data.getRange(0, 5).length:data.length,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    final item = data[i];
                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, rDetailArticle,arguments: item.id);
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: BaseColor.base),
                            color: BaseColor.white,
                            boxShadow: boxShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8)),
                                    image: DecorationImage(
                                      image: NetworkImage(item.imageUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item.title!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
