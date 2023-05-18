import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project2/models/restaurants_model.dart';

class CartModel {
  String? id;
  String? itemName;
  String? itemPrice;
  String? weight;
  String? imagePath;
  int? quantity;
  bool? isExist;
  String? time;
  Items? item;

  CartModel({
    this.id,
    this.itemName,
    this.itemPrice,
    this.weight,
    this.imagePath,
    this.quantity,
    this.isExist,
    this.time,
    this.item,
  });

  CartModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        itemName = json['itemName'],
        itemPrice = json['itemPrice'],
        weight = json['weight'],
        imagePath = json['imagePath'],
        quantity = json['quantity'],
        isExist = json['isExist'],
        time = json['time'],
        item = Items.fromJson(json['item']);

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
    data['item'] = this.item!.toJson();
    return data;
  }

  /*Map<String, dynamic> toJson2() {
    return{
      "id": this.id,
      "itemName": this.itemName,
      "itemPrice": this.itemPrice,
      "weight": this.weight,
      "imagePath": this.imagePath,
      "quantity": this.quantity,
      "isExist": this.isExist,
      "time": this.time
    };
  }*/
}
