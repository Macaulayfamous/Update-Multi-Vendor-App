import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maclay_multi_store/provider/cart_provider.dart';
import 'package:maclay_multi_store/views/buyers/productDetail/product_detail_screen.dart';
import 'package:maclay_multi_store/views/buyers/productDetail/widget/videoplay_Item.dart';
import 'package:provider/provider.dart';

import '../productDetail/vendor_store_detail_screen.dart';

class VideoDisplayScreen extends StatelessWidget {
  const VideoDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    final Stream<QuerySnapshot> _products =
        FirebaseFirestore.instance.collection('products').snapshots();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _products,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }

          return Scaffold(
            body: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];

                List productImage = productData['imageUrl'];

                return Stack(
                  children: [
                    productData['videoUrl'] == ""
                        ? Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductDetailScreen(
                                      productData: productData);
                                }));
                              },
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 200.0,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                                items: productImage.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Container(
                                          
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Image.network(
                                              i,
                                              fit: BoxFit.contain,
                                            )),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          )

                        // Center(
                        //     child: Image.network(
                        //       productData['imageUrl'][0],
                        //       fit: BoxFit.contain,
                        //     ),
                        //   )
                        : VideoPlayerItem(
                            videoUrl: productData['videoUrl'],
                          ),
                    Positioned(
                        top: 60,
                        left: 30,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage:
                              NetworkImage(productData['storeImage']),
                        )),
                    Positioned(
                      bottom: 35,
                      left: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productData['bussinessName'],
                            style: TextStyle(
                              color: productData['videoUrl'] == ''
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 6,
                            ),
                          ),
                          Text(
                            productData['countryValue'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      right: 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            productData['productName'],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 6,
                            ),
                          ),
                          Text(
                            '\$' +
                                ' ' +
                                productData['productPrice'].toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              _cartProvider.addProductToCart(
                                  productData['productName'],
                                  productData['productId'],
                                  productData['imageUrl'],
                                  1,
                                  productData['quantity'],
                                  productData['productPrice'],
                                  productData['vendorId'],
                                  '',
                                  productData['scheduleDate']);

                              Get.snackbar(
                                'ITEM ADDED',
                                'You Added ${productData['productName']} To Your Cart',
                                margin: EdgeInsets.all(20),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.blue.shade900,
                                colorText: Colors.white,
                              );
                            },
                            child: Text(
                              'ADD TO CART',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
