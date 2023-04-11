import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String name;
  String description;
  String costs;
  String? img;
  String? phone;
  String? time;
  List<Address>? address;
  List<Menu>? menu;
  int restaurantCount;

  RestaurantModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.costs,
      this.img,
      this.phone,
      this.time,
      this.address,
      required this.restaurantCount,
      this.menu});

  RestaurantModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        description = json['description'],
        costs = json['costs'] as String,
        img = json['img'] as String,
        phone = json['phone'] as String,
        time = json['time'] as String,
        restaurantCount = 0,
        address = (json['address'] as List)
            .map((dynamic e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
        menu = (json['menu'] as List)
            .map((dynamic e) => Menu.fromJson(e as Map<String, dynamic>))
            .toList();

  RestaurantModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        name = json['name'],
        description = json['description'],
        costs = json['costs'],
        img = json['img'],
        phone = json['phone'],
        time = json['time'],
        // address = (json['address'] as List)
        //     .map((dynamic e) => Address.fromJson(e as Map<String, dynamic>))
        //     .toList(),
        address = [],
        restaurantCount = 1,//json['restaurant_count'] as int,
        menu = [];

  /*String timeClose() {
    final openTime = time?.split('-')[0].trim();
    final closeTime = time?.split('-')[1].trim();

    final timeNow = DateTime.now();
    final closeDateTime = DateTime(
      timeNow.year,
      timeNow.month,
      timeNow.day,
      int.parse(closeTime!.split(':')[0]),
      int.parse(closeTime.split(':')[1]),
    );

    final difference = closeDateTime.difference(timeNow);

    final hours = difference.inHours.toString().padLeft(2, '0');
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes до закрытия';
  }*/
  String timeClose() {
    final openTime = time?.split('-')[0].trim();
    final closeTime = time?.split('-')[1].trim();

    final timeNow = DateTime.now();
    final closeDateTime = DateTime(
      timeNow.year,
      timeNow.month,
      timeNow.day,
      int.parse(closeTime!.split(':')[0]),
      int.parse(closeTime.split(':')[1]),
    );

    if (timeNow.isAfter(closeDateTime)) {
      final openDateTime = DateTime(
        timeNow.year,
        timeNow.month,
        timeNow.day + 1,
        int.parse(openTime!.split(':')[0]),
        int.parse(openTime.split(':')[1]),
      );

      final difference = openDateTime.difference(timeNow);

      final hours = difference.inHours.toString().padLeft(2, '0');
      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      return '$hours:$minutes до открытия';
    }

    final difference = closeDateTime.difference(timeNow);

    final hours = difference.inHours.toString().padLeft(2, '0');
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes до закрытия';
  }

  bool isClosed() {
    final openTime = time?.split('-')[0].trim();
    final closeTime = time?.split('-')[1].trim();

    final timeNow = DateTime.now();
    final openDateTime = DateTime(
      timeNow.year,
      timeNow.month,
      timeNow.day,
      int.parse(openTime!.split(':')[0]),
      int.parse(openTime.split(':')[1]),
    );
    final closeDateTime = DateTime(
      timeNow.year,
      timeNow.month,
      timeNow.day,
      int.parse(closeTime!.split(':')[0]),
      int.parse(closeTime.split(':')[1]),
    );

    return timeNow.isBefore(openDateTime) || timeNow.isAfter(closeDateTime);
  }

  bool isClosingSoon() {
    final openTime = time?.split('-')[0].trim();
    final closeTime = time?.split('-')[1].trim();

    final timeNow = DateTime.now();
    final closeDateTime = DateTime(
      timeNow.year,
      timeNow.month,
      timeNow.day,
      int.parse(closeTime!.split(':')[0]),
      int.parse(closeTime.split(':')[1]),
    );

    final difference = closeDateTime.difference(timeNow);
    return difference.inMinutes <= 59;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['costs'] = this.costs;
    data['img'] = this.img;
    data['phone'] = this.phone;
    data['time'] = this.time;
    // if (this.address != null) {
    //   data['address'] = this.address.map((v) => v.toJson()).toList();
    // }
    // if (this.menu != null) {
    //   data['menu'] = this.menu.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Address {
  String id;
  String? street;
  String? city;

  Address({required this.id, this.street, this.city});

  Address.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        street = json['street'],
        city = json['city'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street'] = this.street;
    data['city'] = this.city;
    return data;
  }
}

class Menu {
  String id;
  String name;
  List<Items> items;

  Menu({required this.id, required this.name, required this.items});

  Menu.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        items = (json['items'] as List).map((e) => Items.fromJson(e)).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String id;
  String? itemName;
  String? itemPrice;
  String? weight;
  String? description;
  String? imagePath;
  String? typeId;

  Items(
      {required this.id,
      this.itemName,
      this.itemPrice,
      this.weight,
      this.description,
      this.imagePath,
      this.typeId});

  Items.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        itemName = json['itemName'],
        itemPrice = json['itemPrice'],
        weight = json['weight'],
        description = json['description'],
        imagePath = json['imagePath'],
        typeId = json['type_id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.itemName;
    data['itemPrice'] = this.itemPrice;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['imagePath'] = this.imagePath;
    data['type_id'] = this.typeId;
    return data;
  }
}

/////////////////////////////////////////////////////////////////
/*
  class Restaurant {
    String? _name;
    String? _description;
    String? _costs;
    String? _img;
    String? _phone;
    String? _time;
    // late List<RestaurantModel> _restaurants;
    // List<RestaurantModel> get restaurants => _restaurants;
    late List<AddressModel> _address;
    List<AddressModel> get address => _address;
    late List<MenuModel> _menu;
    List<MenuModel> get menu => _menu;

    Restaurant(
        {required name,
        required description,
        required costs,
        required img,
        required phone,
        required time,
        required address,
        required menu,
        // required restaurants
        }) {
      this._name = name;
      this._description = description;
      this._costs = costs;
      this._img = img;
      this._phone = phone;
      this._time = time;
      // this._restaurants = restaurants;
      this._address = address;
      this._menu = menu;
    }

    Restaurant.fromJson(Map<String, dynamic> json) {
      _name = json['name'];
      _description = json['description'];
      _costs = json['costs'];
      _img = json['img'];
      _phone = json['phone'];
      _time = json['time'];
      // if (json['restaurants'] != null) {
      //   _restaurants = <RestaurantModel>[];
      //   json['restaurants'].forEach((v) {
      //     _restaurants!.add(RestaurantModel.fromJson(v));
      //   });
      // }
      if (json['address'] != null) {
        _address = <AddressModel>[];
        json['address'].forEach((v) {
          _address!.add(AddressModel.fromJson(v));
        });
      }
      if (json['menu'] != null) {
        _menu = <MenuModel>[];
        json['menu'].forEach((v) {
          _menu!.add(MenuModel.fromJson(v));
        });
      }
    }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['costs'] = this.costs;
  //   data['img'] = this.img;
  //   data['phone'] = this.phone;
  //   data['time'] = this.time;
  //   if (this.address != null) {
  //     data['address'] = this.address!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.menu != null) {
  //     data['menu'] = this.menu!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
  }

  class AddressModel {
    String? street;
    String? city;

    AddressModel({this.street, this.city});

    AddressModel.fromJson(Map<String, dynamic> json) {
      street = json['street'];
      city = json['city'];
    }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['street'] = this.street;
  //   data['city'] = this.city;
  //   return data;
  // }
  }

  class MenuModel {
    int? id;
    String? itemName;
    String? itemPrice;
    String? weight;
    String? description;
    String? imagePath;
    int? typeId;

    MenuModel(
        {this.id,
        this.itemName,
        this.itemPrice,
        this.weight,
        this.description,
        this.imagePath,
        this.typeId});

    MenuModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      itemName = json['itemName'];
      itemPrice = json['itemPrice'];
      weight = json['weight'];
      description = json['description'];
      imagePath = json['imagePath'];
      typeId = json['type_id'];
    }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['itemName'] = this.itemName;
  //   data['itemPrice'] = this.itemPrice;
  //   data['weight'] = this.weight;
  //   data['description'] = this.description;
  //   data['imagePath'] = this.imagePath;
  //   data['type_id'] = this.typeId;
  //   return data;
  // }
  }
  */
/////////////////////////////////////////////////////////////////
