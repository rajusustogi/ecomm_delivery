class CompletePackager {
  List<CompletePackagerData> data;

  CompletePackager({this.data});

  CompletePackager.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CompletePackagerData>();
      json['data'].forEach((v) {
        data.add(new CompletePackagerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletePackagerData {
  int id;
  dynamic orderId;
  dynamic userId;
  List<Products> products;
  dynamic amount;
  dynamic deliveryCharge;
  String deliveryAddress;
  dynamic packagerId;
  dynamic deliveryManId;
  String paymentStatus;
  String orderStatus;
  String deliveryDate;
  dynamic invoiceUrl;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  User user;

  CompletePackagerData(
      {this.id,
      this.orderId,
      this.userId,
      this.products,
      this.amount,
      this.deliveryCharge,
      this.deliveryAddress,
      this.packagerId,
      this.deliveryManId,
      this.paymentStatus,
      this.orderStatus,
      this.deliveryDate,
      this.invoiceUrl,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

  CompletePackagerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    amount = json['amount'];
    deliveryCharge = json['delivery_charge'];
    deliveryAddress = json['delivery_address'];
    packagerId = json['packager_id'];
    deliveryManId = json['delivery_man_id'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    deliveryDate = json['delivery_date'];
    invoiceUrl = json['invoice_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['delivery_charge'] = this.deliveryCharge;
    data['delivery_address'] = this.deliveryAddress;
    data['packager_id'] = this.packagerId;
    data['delivery_man_id'] = this.deliveryManId;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['delivery_date'] = this.deliveryDate;
    data['invoice_url'] = this.invoiceUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Products {
  dynamic productId;
  int noOfUnits;
  String manufacturer;
  dynamic rate;
  String packSize;
  String title;
  String imageUrl;
  dynamic mrp;

  Products(
      {this.productId,
      this.noOfUnits,
      this.manufacturer,
      this.rate,
      this.packSize,
      this.title,
      this.imageUrl,
      this.mrp});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    noOfUnits = json['no_of_units'];
    manufacturer = json['manufacturer'];
    rate = json['rate'];
    packSize = json['pack_size'];
    title = json['title'];
    imageUrl = json['image_url'];
    mrp = json['mrp'];
  }
  Products copyWith({
    int noOfUnits,
  }) =>
      Products(
          productId: this.productId,
          noOfUnits: noOfUnits ?? this.noOfUnits,
          manufacturer: this.manufacturer,
          imageUrl: this.imageUrl,
          mrp: this.mrp,
          packSize: this.packSize,
          rate: this.rate,
          title: this.title);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['no_of_units'] = this.noOfUnits;
    data['manufacturer'] = this.manufacturer;
    data['rate'] = this.rate;
    data['pack_size'] = this.packSize;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['mrp'] = this.mrp;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String mobileNo;
  String alternateNo;
  String password;
  String address;
  String landmark;
  String state;
  String pincode;
  dynamic deliveryCharge;
  String latitude;
  String longitude;
  List<dynamic> favorites;
  bool isActive;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobileNo,
      this.alternateNo,
      this.password,
      this.address,
      this.landmark,
      this.state,
      this.pincode,
      this.deliveryCharge,
      this.latitude,
      this.longitude,
      this.favorites,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    alternateNo = json['alternate_no'];
    password = json['password'];
    address = json['address'];
    landmark = json['landmark'];
    state = json['state'];
    pincode = json['pincode'];
    deliveryCharge = json['delivery_charge'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    favorites = json['favorites'].cast<int>();
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['alternate_no'] = this.alternateNo;
    data['password'] = this.password;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['delivery_charge'] = this.deliveryCharge;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['favorites'] = this.favorites;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
