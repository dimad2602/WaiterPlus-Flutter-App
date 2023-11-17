class UserModel {
  int id;
  String name;
  String email;
  //String phone;
  //int orderCount;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      //required this.phone,
      //required this.orderCount
      });

  // user from bd
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        //справа пишетсяф также как в BD
        id: json['id'],
        name: json['name'],
        email: json['email'],
        //phone: json['phone'],
        //orderCount: json['order_сount']
        );
  }
}
