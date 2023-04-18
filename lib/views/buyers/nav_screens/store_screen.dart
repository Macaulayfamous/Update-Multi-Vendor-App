import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maclay_multi_store/views/buyers/productDetail/vendor_store_detail_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _storesStream = FirebaseFirestore.instance
        .collection('vendors')
        .where('approved', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _storesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Store Owners',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 150,
                      child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 8,
                            childAspectRatio: 2 / 3,
                          ),
                          itemBuilder: (context, Index) {
                            final storeData = snapshot.data!.docs[Index];
                            return InkWell(
                              onTap: () {
                                Get.to(VendorStoreDetail(vendorData: storeData));
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage(storeData['storeImage']),
                                  ),
                                  Text(storeData['bussinessName']),
                                ],
                              ),
                            );
                          }))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
