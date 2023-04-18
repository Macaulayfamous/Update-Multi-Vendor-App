// class OrderModel {
//   final bool? accepted;

//   final String? address;

//   final String? buyerId;

//   final String? buyerPhoto;

//   final String? countryValue;

//   final String? email;

//   final String? phoneNumber;

//   final String? stateValue;
//   final String? storeImage;

//   final String? taxNumber;

//   final String? taxRegistered;

//   OrderModel(
//       {required this.accepted,
//       required this.address,
//       required this.buyerId,
//       required this.buyerPhoto,
//       required this.countryValue,
//       required this.email,
//       required this.phoneNumber,
//       required this.stateValue,
//       required this.storeImage,
//       required this.taxNumber,
//       required this.taxRegistered});

//   OrderModel.fromJson(Map<String, Object?> json)
//       : this(
//           accepted: json['accepted']! as bool,
//           address: json['address']! as String,
//           buyerId: json['bussinessName']! as String,
//           buyerPhoto: json['cityValue']! as String,
//           countryValue: json['countryValue']! as String,
//           email: json['email']! as String,
//           phoneNumber: json['phoneNumber']! as String,
//           stateValue: json['stateValue']! as String,
//           storeImage: json['storeImage']! as String,
//           taxNumber: json['taxNumber']! as String,
//           taxRegistered: json['taxRegistered']! as String,
//         );

//   Map<String, Object?> toJson() {
//     return {
//       'accepted': accepted,
//       'address': address,
//       'buyerId': buyerId,
//       'buyerPhoto': buyerPhoto,
//       'countryValue': countryValue,
//       'email': email,
//       'phoneNumber': phoneNumber,
//       'stateValue': stateValue,
//       'storeImage': storeImage,
//       'taxNumber': taxNumber,
//       'taxRegistered': taxRegistered,
//     };
//   }
// }
