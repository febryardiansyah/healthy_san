import 'package:flutter/material.dart';
import 'package:healthy_san/utils/base_color.dart';
import 'package:healthy_san/utils/styles.dart';

class ForYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context,i){
          return Container(
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
                            image: NetworkImage('https://asset.kompas.com/crops/ncgvDkq11ovx_624dxbv483x_iY=/0x0:648x432/750x500/data/photo/2021/10/05/615c371c61b81.jpg'),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                      SizedBox(width: 4,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bibol Nur Injiyani',style: TextStyle(fontWeight: FontWeight.bold,)),
                          Text('1 Februari 2021'),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 8,),
                Text('Hi, saya ingin bertanya mengenai manfaat daun jambu. Apakah ada yang bisa membantu?'),
                SizedBox(height: 8,),
                Divider(
                  color: BaseColor.base,
                ),
                Text('20 Jawaban',style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}
