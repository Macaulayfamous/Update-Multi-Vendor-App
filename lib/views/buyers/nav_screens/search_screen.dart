import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import '../productDetail/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchedValue = '';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: TextFormField(
            onChanged: (value) {
              setState(() {
                searchedValue = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Searching For Products',
              labelStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 5,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: _productsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }

              final searhData = snapshot.data!.docs.where((element) {
                return element['productName']
                    .toLowerCase()
                    .contains(searchedValue.toLowerCase());
              });

              return searchedValue == ''
                  ? Center(
                      child: Text(
                        'You Can\nSearch For Products',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      children: searhData.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductDetailScreen(productData: e);
                            }));
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 72 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffdddddd)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // ff038aec2404b521745019a2e49356 (20:5)

                                        width: 48 * fem,
                                        height: 50 * fem,
                                        child: Image.network(
                                          e['imageUrl'][0],
                                          fit: BoxFit.cover,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // fasiontrendRmS (4:9)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  9 * fem),
                                              child: Text(e['productName']
                                                  // style: SafeGoogleFont(
                                                  //   'Inria Sans',
                                                  //   fontSize: 21 * ffem,
                                                  //   fontWeight: FontWeight.w400,
                                                  //   height: 1.1975 * ffem / fem,
                                                  //   letterSpacing: 0.525 * fem,
                                                  //   color: Color(0xff000000),
                                                  // ),
                                                  ),
                                            ),
                                            Container(
                                              // autogroupfwwaWnt (9222B518a6PKvFYB77FWwA)
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    // ratingsVHS (6:15)
                                                    '(4-5 ratings)',
                                                    // style: SafeGoogleFont(
                                                    //   'Inria Sans',
                                                    //   fontSize: 12 * ffem,
                                                    //   fontWeight: FontWeight.w700,
                                                    //   height: 1.1975 * ffem / fem,
                                                    //   letterSpacing: 0.18 * fem,
                                                    //   color: Color(0xff828282),
                                                    // ),
                                                  ),
                                                  Container(
                                                    // xpX (10:21)

                                                    child: Text(
                                                      '\$ 16.25',
                                                      // style: SafeGoogleFont(
                                                      //   'Inter',
                                                      //   fontSize: 14 * ffem,
                                                      //   fontWeight: FontWeight.w600,
                                                      //   height: 1.2125 * ffem / fem,
                                                      //   color: Color(0xff000000),
                                                      // ),
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
                                    badgeContent: e['bestseller'] == true
                                        ? Text(
                                            'BestSelling',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Text(
                                            'New ',
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
                      }).toList(),
                    );
            },
          ),
        ));
  }
}
