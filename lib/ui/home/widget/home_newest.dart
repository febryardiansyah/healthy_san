import 'package:flutter/material.dart';
import 'package:healthy_san/utils/styles.dart';

import '../../../utils/base_color.dart';

class HomeNewest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          itemCount: 4,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context,i){
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
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
                            image: NetworkImage('https://asset.kompas.com/crops/1y4AYAV9kzrAARMP-IpF_CdWKE4=/0x0:0x0/750x500/data/photo/2020/10/24/5f93dccf663f5.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8)
                        ),
                      ),
                    ),
                    SizedBox(width: 4,),
                    Expanded(
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Manfaat Daun Pepaya Ampuh Benget, Penyakit Kronis Rontok',style: TextStyle(fontWeight: FontWeight.bold,)),
                            Text('Meski rasanya pahit, daun pepaya rupanya telah lama dikenal..'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
