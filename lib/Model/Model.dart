// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Model {
  String? email;
  String? fullname;
  String? number;
  String? address;
  String? decp;
  String? uid;
  Model({
    this.email,
    this.fullname,
    this.number,
    this.address,
    this.decp,
    this.uid,
  });

  Model copyWith({
    String? email,
    String? fullname,
    String? number,
    String? address,
    String? decp,
    String? uid,
  }) {
    return Model(
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      number: number ?? this.number,
      address: address ?? this.address,
      decp: decp ?? this.decp,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullname': fullname,
      'number': number,
      'address': address,
      'decp': decp,
      'uid': uid,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      email: map['email'] != null ? map['email'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      decp: map['decp'] != null ? map['decp'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Model(email: $email, fullname: $fullname, number: $number, address: $address, decp: $decp, uid: $uid)';
  }

  @override
  bool operator ==(covariant Model other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.fullname == fullname &&
      other.number == number &&
      other.address == address &&
      other.decp == decp &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      fullname.hashCode ^
      number.hashCode ^
      address.hashCode ^
      decp.hashCode ^
      uid.hashCode;
  }
}

class Place {
  String? placename;
  String? placeaddress;
  String? price;
  String? imgurl;
  Place({
    this.placename,
    this.placeaddress,
    this.price,
    this.imgurl,
  });

  Place copyWith({
    String? placename,
    String? placeaddress,
    String? price,
    String? imgurl,
  }) {
    return Place(
      placename: placename ?? this.placename,
      placeaddress: placeaddress ?? this.placeaddress,
      price: price ?? this.price,
      imgurl: imgurl ?? this.imgurl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'placename': placename,
      'placeaddress': placeaddress,
      'price': price,
      'imgurl': imgurl,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      placename: map['placename'] != null ? map['placename'] as String : null,
      placeaddress: map['placeaddress'] != null ? map['placeaddress'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      imgurl: map['imgurl'] != null ? map['imgurl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Place(placename: $placename, placeaddress: $placeaddress, price: $price, imgurl: $imgurl)';
  }

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;
  
    return 
      other.placename == placename &&
      other.placeaddress == placeaddress &&
      other.price == price &&
      other.imgurl == imgurl;
  }

  @override
  int get hashCode {
    return placename.hashCode ^
      placeaddress.hashCode ^
      price.hashCode ^
      imgurl.hashCode;
  }
}
