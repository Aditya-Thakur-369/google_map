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




































// // Important Packages
// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_map/Backend/Utils.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart' show Lottie;
// import 'package:provider/provider.dart';
// import 'dart:ui' as ui;

// import '../Backend/Provider.dart';
// import '../Model/Model.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   //  Text Editing Controlleres for Form
//   TextEditingController placename = TextEditingController();
//   TextEditingController placeaddress = TextEditingController();
//   TextEditingController price = TextEditingController();

//   bool isvisible = false;
//   static String? imageurl;
//   CustomInfoWindowController custominfowindowcontroller =
//       CustomInfoWindowController();
//   // List Of Markers of location
//   List<Marker> _marker = [];
//   List<Marker> _list = [];
 



//   // Getting Markers in map
//   getmarksers() async {
//     final Uint8List markerIcon =
//         await Utils.getBytefromassets("assets/icon/locationmap.png", 200);
//     CollectionReference _collectionRef =
//         FirebaseFirestore.instance.collection('Users');

//     QuerySnapshot querySnapshot = await _collectionRef.get();

//     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
//     log(allData.toString());

//     List<Map<String, dynamic>> myDataList = List.from(allData);
//     for (int i = 0; i < myDataList.length; i++) {
//       _marker.addAll(List.generate(myDataList.length, (index) {
//         if (myDataList.elementAt(index)['lat'] != null &&
//             myDataList.elementAt(index)['log'] != null) {
//           setState(() {});
//           final LatLng ltlg = LatLng(myDataList.elementAt(index)['lat'],
//               myDataList.elementAt(index)['log']);

//           return Marker(
//               markerId: MarkerId(myDataList.elementAt(index)['email']),
//               icon: BitmapDescriptor.fromBytes(markerIcon),
//               position: LatLng(
//                 myDataList.elementAt(index)['lat'],
//                 myDataList.elementAt(index)['log'],
//               ),
//               onTap: () async {
//                 print('Marker ${index + 1} tapped');
//                 print('Latitude: ${myDataList.elementAt(index)['lat']}');
//                 print('Longitude: ${myDataList.elementAt(index)['log']}');
//                 Provider.of<CardProvider>(context,listen: true).getcard(myDataList.elementAt(index)['lat'], myDataList.elementAt(index)['log']);
//                 // .getcard(myDataList.elementAt(index)['lat'],
//                 //     myDataList.elementAt(index)['log']);

//                 CameraPosition cameraPosition = CameraPosition(
//                     target: LatLng(myDataList.elementAt(index)['lat'],
//                         myDataList.elementAt(index)['log']),
//                     zoom: 14);
//                 final GoogleMapController controller = await _controller.future;
//                 controller.animateCamera(
//                     CameraUpdate.newCameraPosition(cameraPosition));
//                 setState(() {
//                   if (isvisible) {
//                     setState(() {
//                       isvisible = false;
//                     });
//                   } else {
//                     setState(() {
//                       isvisible = true;
//                     });
//                   }
//                 });

//                 // Custom Window Start
//                 setState(() {
//                   custominfowindowcontroller.addInfoWindow!(
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       width: 350,
//                       child: Expanded(
//                         child: Consumer<CardProvider>(
//                           builder: (context, card, child) => 
//                            Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 140,
//                                 width: 80,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10)),
//                                   image: DecorationImage(
//                                     image: card.pimg != null
//                                         ? NetworkImage('${card.pimg}')
//                                         : AssetImage("assets/icon/load.webp")
//                                             as ImageProvider,
//                                     // https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=MnwxfDB8MXxyYW5kb218MHx8cGl6emEsZm9vZHx8fHx8fDE2ODEyMjg1NjE&ixlib=rb-4.0.3&q=80&w=1900
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   // child: Container(
//                                   //   height: 140,
//                                   //   width: 120,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           card.pname != null
//                                               ? '${card.pname}'
//                                               : "Loading Data !!",
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         const SizedBox(height: 2),
//                                         SingleChildScrollView(
//                                           scrollDirection: Axis.horizontal,
//                                           child: Row(
//                                             children: [
//                                               const Icon(Icons.location_on,
//                                                   size: 14, color: Colors.grey),
//                                               SizedBox(width: 2),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 5),
//                                                 child: Text(
//                                                   card.paddress != null
//                                                       ? '${card.paddress}'
//                                                       : "Please Wait ",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.grey[600]),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 3),
//                                         Row(
//                                           children: [
//                                             const Icon(Icons.star,
//                                                 size: 12, color: Colors.amber),
//                                             const Icon(Icons.star,
//                                                 size: 12, color: Colors.amber),
//                                             const Icon(Icons.star,
//                                                 size: 12, color: Colors.amber),
//                                             const Icon(Icons.star,
//                                                 size: 12, color: Colors.amber),
//                                             const SizedBox(width: 1),
//                                             Text(
//                                               '4.5',
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.grey[600]),
//                                             ),
//                                             const SizedBox(width: 3),
//                                           ],
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               card.pprice != null
//                                                   ? '\$${card.pprice}'
//                                                   : "We Are Fetching Up Detailes ",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 12,
//                                                   color: Colors.grey[600]),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               //   )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     ltlg,
//                   );
//                 });

//                 //  Close
//               },
//               infoWindow:
//                   InfoWindow(title: myDataList.elementAt(index)['email']));
//         } else {
//           return Marker(
//               markerId: MarkerId(myDataList.elementAt(index)['email']));
//         }
//       }));
//       setState(() {});
//     }
//   }

//   //  Initial location to current location Variable
//   static final cameraPosition =
//       const CameraPosition(target: LatLng(00.000000, 00.0000000));
//   Completer<GoogleMapController> _controller = Completer();

//   // Getting Current Location Function
//   Future<Position> getcurrentlocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) {
//       print("Error " + error.toString());
//     });

//     return await Geolocator.getCurrentPosition();
//   }

// // Variable to store address get from coordiates
//   static String stdadd = "";
//   // User Live Location Function
//   loaddata() async {
//     await getcurrentlocation().then((value) async {
//       // Line For getting Address
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(value.latitude, value.longitude);
//       setState(() {
//         stdadd = placemarks.reversed.last.country.toString() +
//             " " +
//             placemarks.reversed.last.locality.toString() +
//             " " +
//             placemarks.reversed.last.subAdministrativeArea.toString() +
//             " " +
//             placemarks.reversed.last.subLocality.toString();
//         setState(() {
//           if (placeaddress.text == null) {
//             setState(() {
//               placeaddress.text = stdadd;
//             });
//           }
//         });

//         log(stdadd.toString());
//       });
//       FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.email)
//           .update({'location': FieldValue.delete()});
//     });
//     await getcurrentlocation().then((value) async {
//       FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.email)
//           .update({
//         "lat": value.latitude,
//         "log": value.longitude,
//       });
//       print(value.latitude.toString() + " " + value.longitude.toString());

//       final Uint8List markerIcon =
//           await Utils.getBytefromassets("assets/icon/locationmap.png", 200);
//       _marker.add(Marker(
//           markerId: const MarkerId("4"),
//           icon: BitmapDescriptor.fromBytes(markerIcon),
//           position: LatLng(value.latitude, value.longitude),
//           infoWindow: const InfoWindow(title: "My Current Location")));
//       CameraPosition cameraPosition = CameraPosition(
//           target: LatLng(value.latitude, value.longitude), zoom: 14);
//       final GoogleMapController controller = await _controller.future;
//       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//       setState(() {});
//     });
//   }

//   // Upload Image
//   static String url = "";
//   uploadImage() async {
//     final _firebaseStorage = FirebaseStorage.instance;
//     final get = FirebaseAuth.instance.currentUser!.email;
//     final _imagePicker = ImagePicker();
//     PickedFile? image;

//     image = await _imagePicker.getImage(
//         source: ImageSource.gallery, imageQuality: 80);

//     if (image != null) {
//       var file = File(image.path);
//       var snapshot =
//           await _firebaseStorage.ref().child('images/$get').putFile(file);
//       var downloadUrl = await snapshot.ref.getDownloadURL();
//       // ---------------------------------------------------------
//       try {
//         FirebaseFirestore.instance
//             .collection("Users")
//             .doc(FirebaseAuth.instance.currentUser!.email)
//             .update({'imgurl': downloadUrl})
//             .then((value) => ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Image Uploaded Successfully"))))
//             .onError((error, stackTrace) => ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text("$error"))))
//             .then((value) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Image Uploaded Successfully !!")));
//             });
//       } catch (e) {
//         log(e.toString());
//       }
//       // -------------------------------------------------------------
//       setState(() {
//         imageurl = downloadUrl;
//         url = downloadUrl;
//         log(imageurl.toString());
//       });
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("No Image Selected !!")));
//       print('No Image Path Received');
//     }
//   }

//   final formkey = GlobalKey<FormState>();
//   addplace() async {
//     showModalBottomSheet(
//       enableDrag: true,
//       isScrollControlled: true,
//       // backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8, top: 8),
//               child: Container(
//                 height: 8,
//                 width: 40,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     color: Colors.grey),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: formkey,
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           uploadImage();
//                           setState(() {
//                             imageurl = url;
//                           });
//                         },
//                         child: Container(
//                           height: 220,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade400),
//                             borderRadius: BorderRadius.all(Radius.circular(15)),
//                             color: Colors.transparent,
//                           ),
//                           child: imageurl == null
//                               ? Center(
//                                   child: Icon(
//                                     Icons.add_a_photo,
//                                     size: 45,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               : Center(
//                                   child: imageurl != null
//                                       ? Image.network(
//                                           imageurl!,
//                                           alignment: Alignment.topCenter,
//                                           fit: BoxFit.cover,
//                                         )
//                                       : Center(
//                                           child: CircularProgressIndicator(
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                 ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       TextFormField(
//                         controller: placename,
//                         keyboardType: TextInputType.name,
//                         decoration: const InputDecoration(
//                             labelText: "Hotel Name",
//                             hintText: "Enter Your Hotel Name ",
//                             prefixIcon: Icon(Icons.abc),
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                         validator: (value) {
//                           if (value!.isEmpty || value.length < 1) {
//                             return "Email Can not be Empty";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       TextFormField(
//                         controller: placeaddress,
//                         keyboardType: TextInputType.streetAddress,
//                         decoration: const InputDecoration(
//                             labelText: "Your Address",
//                             hintText: "Enter Your Address  ",
//                             prefixIcon: Icon(Icons.abc),
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                         validator: (value) {
//                           if (value!.isEmpty || value.length < 1) {
//                             return "Adress Can not be Empty";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       TextFormField(
//                         controller: price,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                             labelText: "Price",
//                             hintText: "Enter Your Price ",
//                             prefixIcon: Icon(Icons.abc),
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)))),
//                         validator: (value) {
//                           if (value!.isEmpty || value.length < 1) {
//                             return "Email Can not be Empty";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 12,
//                       ),
//                       ElevatedButton(
//                         child: const Text("Add Place"),
//                         style: ElevatedButton.styleFrom(
//                             side: BorderSide(width: 1, color: Colors.brown),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30)),
//                             padding: EdgeInsets.only(
//                                 top: 13, bottom: 13, left: 130, right: 130)),
//                         onPressed: () {
//                           saveplace();
//                         },
//                       ),
//                       ElevatedButton(
//                         child: const Text(
//                           "Delete Place",
//                           style: TextStyle(color: Colors.red),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                             side: BorderSide(width: 1, color: Colors.brown),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30)),
//                             padding: EdgeInsets.only(
//                                 top: 11, bottom: 11, left: 125, right: 125)),
//                         onPressed: () {
//                           deleteplace();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   deleteplace() async {
//     await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(FirebaseAuth.instance.currentUser!.email)
//         .update({
//       "placename": null,
//       "placeaddress": null,
//       "price": null,
//       "imgurl": null
//     }).then((value) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Place Deleted Successfully !!")));
//       setState(() {
//         placename.text = "";
//         placeaddress.text = stdadd;
//         price.text = "";
//         imageurl = null;
//       });
//     });
//   }

//   getplace() async {
//     await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(FirebaseAuth.instance.currentUser!.email)
//         .get()
//         .then((DocumentSnapshot doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       Place a = Place(
//         imgurl: data['imgurl'],
//         placename: data['placename'] ?? "",
//         placeaddress: data['placeaddress'] ?? "",
//         price: data['price'] ?? "",
//       );
//       setState(() {
//         imageurl = a.imgurl;
//         placename.text = a.placename!;
//         placeaddress.text = a.placeaddress!;
//         price.text = a.price!;
//         log(placename.text);
//       });
//     });
//   }

//   saveplace() {
//     if (formkey.currentState!.validate()) {
//       FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.email)
//           .update({
//             "placename": placename.text.trim(),
//             "placeaddress": placeaddress.text.trim(),
//             "price": price.text.trim()
//           })
//           .onError((error, stackTrace) => (error, stackTrace) {
//                 log("Error : " + error.toString());
//               })
//           .then((value) {
//             Navigator.pop(context);
//             ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Place Added Successfully !!")));
//           });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timestamp) {
//       getplace();
//       getmarksers();
//       loaddata();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: Stack(children: [
//             GoogleMap(
//                 zoomControlsEnabled: false,
//                 initialCameraPosition: cameraPosition,
//                 markers: Set<Marker>.of(_marker),
//                 onCameraMove: (position) {
//                   custominfowindowcontroller.onCameraMove!();
//                 },
//                 onTap: (argument) {
//                   custominfowindowcontroller.hideInfoWindow!();
//                   if (isvisible) {
//                     setState(() {
//                       isvisible = false;
//                     });
//                   }
//                 },
//                 onMapCreated: (GoogleMapController controller) {
//                   _controller.complete(controller);
//                   custominfowindowcontroller.googleMapController = controller;
//                 }),
//             CustomInfoWindow(
//               controller: custominfowindowcontroller,
//               height: 100,
//               width: 200,
//               offset: 35,
//             ),
//             Visibility(
//                 visible: isvisible,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: 140,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Consumer<CardProvider>(
//                         builder: (context, card, child) =>  Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 140,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     bottomLeft: Radius.circular(10)),
//                                 image: DecorationImage(
//                                   image: card.pimg != null
//                                       ? NetworkImage('${card.pimg}')
//                                       : AssetImage("assets/icon/load.webp")
//                                           as ImageProvider,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Container(
//                                 //   height: 140,
//                                 //   width: 120,
//                                 // child:
//                                 Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           card.pname != null
//                                               ? '${card.pname}'
//                                               : " Loading Data ",
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         const SizedBox(height: 2),
//                                         SingleChildScrollView(
//                                           scrollDirection: Axis.horizontal,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const Icon(Icons.location_on,
//                                                   size: 14, color: Colors.grey),
//                                               const SizedBox(width: 2),
//                                               Text(
//                                                 card.paddress != null
//                                                     ? '${card.paddress}'
//                                                     : 'We Are Fetching Detail',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.grey[600]),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             const Icon(Icons.star,
//                                                 size: 14, color: Colors.amber),
//                                             const SizedBox(width: 1),
//                                             const Icon(Icons.star,
//                                                 size: 14, color: Colors.amber),
//                                             const SizedBox(width: 1),
//                                             const Icon(Icons.star,
//                                                 size: 14, color: Colors.amber),
//                                             const SizedBox(width: 1),
//                                             const Icon(Icons.star,
//                                                 size: 14, color: Colors.amber),
//                                             const SizedBox(width: 3),
//                                             Text(
//                                               '4.5',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 14,
//                                                   color: Colors.purple.shade800),
//                                             ),
//                                             const SizedBox(width: 3),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               card.pprice != null
//                                                   ? '\$${card.pprice} '
//                                                   : "Please Wait",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 17,
//                                                   color: Colors.purple),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 // )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ))
//           ]),
//         ),
//         floatingActionButton: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 30),
//               child: FloatingActionButton(
//                   onPressed: () async {
//                     addplace();
//                   },
//                   shape: CircleBorder(),
//                   child: Image.asset(
//                     "assets/icon/addplace.png",
//                     height: 45,
//                     width: 45,
//                   )),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             // Second Action Button to Navigate User to Current location
//             FloatingActionButton(
//               shape: CircleBorder(),
//               elevation: 5,
//               onPressed: () async {
//                 loaddata();
//               },
//               child: Image.asset(
//                 "assets/icon/locationmap.png",
//                 height: 45,
//                 width: 45,
//               ),
//             ),
//           ],
//         ));
//   }
// }
