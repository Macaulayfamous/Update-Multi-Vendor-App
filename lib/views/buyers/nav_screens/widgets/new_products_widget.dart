import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../productDetail/widget/productDetailModel.dart';

class NewProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('approved', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LinearProgressIndicator(
              color: Colors.yellow.shade900,
            ),
          );
        }

        return Container(
          height: 100,
          child: PageView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final prouctData = snapshot.data!.docs[index];
              return ProductDetailModel(
                prouctData: prouctData,
                fem: fem,
              );
            },
          ),
        );
      },
    );
  }
}
