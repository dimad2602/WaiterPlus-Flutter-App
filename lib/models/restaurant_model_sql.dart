class RestaurantModelSql {
  int? id;
  Brand? brand;
  String? description;
  String? img;
  String? address;
  int? costs;
  String? phone;
  String? time;
  Geometry? geometry;
  //List<String>? employees;
  List<Menu>? menu;

  RestaurantModelSql({
    this.id,
    this.brand,
    this.description,
    this.img,
    this.address,
    this.costs,
    this.phone,
    this.time,
    //this.employees,
    this.menu
  });

  RestaurantModelSql.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int;
      brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
      description = json['description'] as String?;
      img = json['img'] as String;
      address = json['address'] as String?;
      costs = json['costs'] as int?;
      phone = json['phone'] as String?;
      time = json['time'] as String?;
      geometry = json['geometry'] != null
          ? new Geometry.fromJson(json['geometry'])
          : null;
      //employees = json['employees'].cast<String>();
      try {
        if (json['menu'] != null) {
          menu = <Menu>[];
          json['menu'].forEach((v) {
            menu!.add(new Menu.fromJson(v));
          });
        }
      } catch (e){
        print ("Ошибка json['menu'] $e");
      }
    } catch (e) {
      print("Ошибка в RestaurantModelSql.fromJson = ${e}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['description'] = this.description;
    data['img'] = this.img;
    data['address'] = this.address;
    data['costs'] = this.costs;
    data['phone'] = this.phone;
    data['time'] = this.time;
    // if (this.geometry != null) {
    //   data['geometry'] = this.geometry!.toJson();
    // }
    //data['employees'] = this.employees;
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // RestaurantModelSql.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
  //     : id = json.id,
  //       name = json['name'],
  //       description = json['description'],
  //       costs = json['costs'],
  //       img = json['img'],
  //       phone = json['phone'],
  //       time = json['time'],
  //       address = [],
  //       menu = [];

  String timeClose() {
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

    if (timeNow.isAfter(closeDateTime)) {
      // Время уже прошло, но заведение еще не открыто
      final openDateTime = DateTime(
        timeNow.year,
        timeNow.month,
        timeNow.day + 1,
        int.parse(openTime.split(':')[0]),
        int.parse(openTime.split(':')[1]),
      );

      final difference = openDateTime.difference(timeNow);

      final hours = difference.inHours.toString().padLeft(2, '0');
      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      return '$hours:$minutes до открытия';
    } else if (timeNow.isBefore(openDateTime)) {
      // Время еще не наступило
      final difference = openDateTime.difference(timeNow);

      final hours = difference.inHours.toString().padLeft(2, '0');
      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      return '$hours:$minutes до открытия';
    } else {
      // Заведение открыто
      final difference = closeDateTime.difference(timeNow);

      final hours = difference.inHours.toString().padLeft(2, '0');
      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      return '$hours:$minutes до закрытия';
    }
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

    // Проверяем, что время еще не прошло
    if (timeNow.isBefore(closeDateTime)) {
      final difference = closeDateTime.difference(timeNow);
      return difference.inMinutes <= 59;
    }

    return false; // Если время уже прошло, возвращаем false
  }
}

class Brand {
  int? id;
  int? company;
  String? name;
  List<String>? restaurants;

  Brand({this.id, this.company, this.name, this.restaurants});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    name = json['name'];
    restaurants = json['restaurants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company'] = this.company;
    data['name'] = this.name;
    data['restaurants'] = this.restaurants;
    return data;
  }
}

class Geometry {
  Geometry();

  Geometry.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Menu {
  int? id;
  String? title;
  List<Items>? items;
  String? rest;

  Menu({this.id, this.title, this.items, this.rest});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    try{
      if (json['items'] != null) {
        items = <Items>[];
        json['items'].forEach((v) {
          items!.add(new Items.fromJson(v));
        });
      }
    }catch(e){
      print("Ошибка json['items'] $e");
    }
    rest = json['rest'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['rest'] = this.rest;
    return data;
  }
}

class Items {
  int? restId;
  int? itemId;
  int? categoryId;
  int? id;
  Item? item;
  String? category;

  Items(
      {this.restId,
      this.itemId,
      this.categoryId,
      this.id,
      this.item,
      this.category});

  Items.fromJson(Map<String, dynamic> json) {
    restId = json['restId'] as int?;
    itemId = json['itemId'] as int?;
    categoryId = json['categoryId'] as int?;
    id = json['id'] as int?;
    try{
      item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    }catch(e){
      print("Ошибка Items.fromJson $e");
    }
    category = json['category'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restId'] = this.restId;
    data['itemId'] = this.itemId;
    data['categoryId'] = this.categoryId;
    data['id'] = this.id;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['category'] = this.category;
    return data;
  }
}

class Item {
  int? id;
  String? title;
  String? description;
  int? weight;
  int? volume;
  int? price;
  String? image;
  List<String>? inMenu;

  Item(
      {this.id,
      this.title,
      this.description,
      this.weight,
      this.volume,
      this.price,
      this.image,
      this.inMenu});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    description = json['description'] as String?;
    weight = json['weight'] as int?;
    volume = json['volume'] as int?;
    price = json['price'] as int?;
    image = json['image'] as String?;
    try{
      inMenu = json['inMenu'] /*.cast<String>()*/ as List<String>?;
    }catch(e){
      print("json['inMenu'] $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['weight'] = this.weight;
    data['volume'] = this.volume;
    data['price'] = this.price;
    data['image'] = this.image;
    data['inMenu'] = this.inMenu;
    return data;
  }
}
