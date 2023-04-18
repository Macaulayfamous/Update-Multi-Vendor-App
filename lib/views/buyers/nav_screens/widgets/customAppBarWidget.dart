import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:maclay_multi_store/views/buyers/nav_screens/store_screen.dart';

class CustomAppBarWidget extends StatefulWidget {
  const CustomAppBarWidget({super.key});

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  String userName = '';
  String profilePhoto = '';

  void getUserData() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('buyers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userName = userData.get('firstName');
      profilePhoto = userData.get('userImage');
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showBottomSheet(
                  elevation: 1000,
                  context: context,
                  builder: (contex) {
                    return Container(height: 200, child: StoreScreen());
                  });
            },
            child: Container(
              // store1oAQ (20:3)
              margin: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 97 * fem, 0 * fem),
              width: 30 * fem,
              height: 30 * fem,
              child: Image.asset(
                'assets/icons/store-1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            // guestsessionxBi (14:2)
            margin: EdgeInsets.fromLTRB(0 * fem, 6 * fem, 94 * fem, 0 * fem),
            child: SizedBox(
              width: 130,
              child: Center(
                child: Text(
                  FirebaseAuth.instance.currentUser == null
                      ? 'Guest Session'
                      : userName.toUpperCase(),
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
          FirebaseAuth.instance.currentUser == null
              ? Container(
                  // notification1Rb6 (20:4)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                  width: 28 * fem,
                  height: 28 * fem,
                  child: Icon(
                    Icons.notification_add,
                  ),
                )
              : Container(
                  // notification1Rb6 (20:4)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                  width: 28 * fem,
                  height: 28 * fem,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(profilePhoto)),
                ),
        ],
      ),
    );
  }
}
