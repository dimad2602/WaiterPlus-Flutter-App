class PlaceOrderBody {
  int? id;
  int? uid;
  int? restid;
  String? status;
  String? createdAt;
  String? completedAt;

  PlaceOrderBody(
      {this.id,
        this.uid,
        this.restid,
        this.status,
        this.createdAt,
        this.completedAt
      });

  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    restid = json['restid'];
    status = json['status'];
    createdAt = json['created_at'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['restid'] = this.restid;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['completed_at'] = this.completedAt;
    return data;
  }
}

// import 'cart_model_sql.dart';
//
// class PlaceOrderBody {
//   List<CartModel>? _cart;
//   late double _orderAmount;
//   late String _orderNote;
//
//   PlaceOrderBody(
//     {required List<CartModel> cart,
//     required double orderAmount,
//     required String orderNote,}) {
//     this._cart = cart;
//     this._orderAmount = orderAmount;
//     this._orderNote = orderNote;
//   }
//
//   List<CartModel> get cart => _cart!;
//   double get orderAmount => _orderAmount;
//   String get orderNote => _orderNote;
//
//   PlaceOrderBody.fromJson(Map<String, dynamic> json){
//     if (json['cart'] != null){
//       _cart = [];
//       json['cart'].forEach((v){
//         _cart!.add(new CartModel.fromJson(v));
//       });
//     }
//     _orderAmount = json['orderAmount'];
//     _orderNote = json['orderNote'];
//   }
//
//   Map<String, dynamic> toJson(){
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//
//     if (this._cart != null){
//       data['cart'] = this._cart!.map((v) => v.toJson()).toList();
//     }
//     data['order_amount'] = this._orderAmount;
//     data['order_note'] = this._orderNote;
//
//     return data;
//   }
// }