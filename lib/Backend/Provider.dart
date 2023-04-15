import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Model.dart';

class CardProvider extends ChangeNotifier{
   
    // Getting  card Details
  String? pimg;
  String? pname;
  String? paddress;
  String? pprice;
  getcard(double lat, double log) async {
    QuerySnapshot<Map<String, dynamic>> d = await FirebaseFirestore.instance
        .collection("Users")
        .where("lat", isEqualTo: lat)
        .where("log", isEqualTo: log)
        // .where("email", isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();

    if (d.docs.isNotEmpty) {
      final data = d.docs.first.data() as Map<String, dynamic>;
      Place a = Place(
        imgurl: data['imgurl'],
        placename: data['placename'] ?? "",
        placeaddress: data['placeaddress'] ?? "",
        price: data['price'] ?? "",
      );
          pimg = a.imgurl;
          pname = a.placename!;
          paddress = a.placeaddress!;
          pprice = a.price!;
          notifyListeners();
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Something went wrong"),
      // ));
    }
  }

}

