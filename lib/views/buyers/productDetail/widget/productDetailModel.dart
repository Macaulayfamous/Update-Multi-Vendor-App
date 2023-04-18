import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import 'package:maclay_multi_store/views/buyers/productDetail/product_detail_screen.dart';

class ProductDetailModel extends StatelessWidget {
  const ProductDetailModel({
    super.key,
    required this.prouctData,
    required this.fem,
  });

  final QueryDocumentSnapshot<Object?> prouctData;
  final double fem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailScreen(productData: prouctData));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 72 * fem,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffdddddd)),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0f000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 6 * fem,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // ff038aec2404b521745019a2e49356 (20:5)

                      width: 48 * fem,
                      height: 50 * fem,
                      child: Image.network(
                        prouctData['imageUrl'][0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // autogroup8r92H9S (92221f79WEsBsbiond8R92)
                    width: 156 * fem,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // fasiontrendRmS (4:9)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 9 * fem),
                          child: Text(
                            prouctData['productName'],
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.525 * fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          // autogroupfwwaWnt (9222B518a6PKvFYB77FWwA)
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // xpX (10:21)

                                child: Text(
                                  '\$' +
                                      prouctData['productPrice']
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.blue,
                ),
                badgeContent: prouctData['bestseller'] == true
                    ? Text(
                        'BestSelling',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        prouctData['trending'] == true
                            ? 'Trending'
                            : prouctData['popular'] == true
                        ? 'Popular'
                                : 'New ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
