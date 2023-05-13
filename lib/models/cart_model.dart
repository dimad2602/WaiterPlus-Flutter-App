import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? id;
  String? itemName;
  String? itemPrice;
  String? weight;
  String? imagePath;
  int? quantity;
  bool? isExist;
  String? time;

  CartModel({
    this.id,
    this.itemName,
    this.itemPrice,
    this.weight,
    this.imagePath,
    this.quantity,
    this.isExist,
    this.time,
  });

  CartModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        itemName = json['itemName'],
        itemPrice = json['itemPrice'],
        weight = json['weight'],
        imagePath = json['imagePath'],
        quantity = json['quantity'],
        isExist = json['isExist'],
        time = json['time'];

  CartModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot['id'],
        itemName = snapshot['itemName'] as String?,
        itemPrice = snapshot['itemPrice'] as String?,
        weight = snapshot['weight'] as String?,
        imagePath = snapshot['imagePath'] as String?,
        quantity = snapshot['quantity'] as int?,
        isExist = snapshot['isExist'] as bool?,
        time = snapshot['time'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.itemName;
    data['itemPrice'] = this.itemPrice;
    data['weight'] = this.weight;
    data['imagePath'] = this.imagePath;
    data['quantity'] = this.quantity;
    data['isExist'] = this.isExist;
    data['time'] = this.time;
    return data;
  }
}
