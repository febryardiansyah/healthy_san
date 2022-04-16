import 'package:flutter/material.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/styles.dart';

class HomePopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.only(right: 8),
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
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(8)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://asset.kompas.com/crops/1y4AYAV9kzrAARMP-IpF_CdWKE4=/0x0:0x0/750x500/data/photo/2020/10/24/5f93dccf663f5.jpg'),
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
                              '7 Jamur Paling Beracun di Dunia yang Bisa Sebabkan Kematian',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
