import 'package:flutter/material.dart';
import 'package:healthy_san/ui/forum/widget/for_you_screen.dart';
import 'package:healthy_san/widgets/my_form.dart';

import '../../utils/base_color.dart';

class ForumScreen extends StatefulWidget {
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context,scroll){
              return [
                SliverAppBar(
                  expandedHeight: 100,
                  floating: true,
                  pinned: false,
                  snap: false,
                  elevation: 0,
                  backgroundColor: BaseColor.base,
                  forceElevated: scroll,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.all(8),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 50,
                                child: MyForm(
                                  hintText: 'Tulis pertanyaan..',
                                  borderRadius: 8,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.add,color: BaseColor.base),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: BaseColor.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppDelegate(TabBar(
                    labelColor: BaseColor.base,
                    unselectedLabelColor: BaseColor.grey,
                    indicatorColor: BaseColor.base,
                    tabs: [
                      Tab(
                        text: 'Untuk kamu',
                        icon: Icon(Icons.rss_feed),
                      ),
                      Tab(
                        text: 'Pertanyaanku',
                        icon: Icon(Icons.question_answer),
                      ),
                    ],
                  )),
                ),
              ];
            },
            body: TabBarView(
              children: [
                ForYouScreen(),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _SliverAppDelegate extends SliverPersistentHeaderDelegate{
  final TabBar _tabBar;

  _SliverAppDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: BaseColor.white,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}