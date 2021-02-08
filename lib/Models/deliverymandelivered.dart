class DeliveredDeliveryModel {
  List<DeliveredDeliveryData> data;

  DeliveredDeliveryModel({this.data});

  DeliveredDeliveryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DeliveredDeliveryData>();
      json['data'].forEach((v) {
        data.add(new DeliveredDeliveryData.fromJson(v));
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

class DeliveredDeliveryData {
  dynamic id;
  dynamic orderId;
  dynamic userId;
  List<Products> products;
  dynamic amount;
  dynamic deliveryCharge;
  String deliveryAddress;
  dynamic packagerId;
  String packager;
  dynamic deliveryManId;
  String deliveryMan;
  String paymentStatus;
  String orderStatus;
  String deliveryDate;
  dynamic invoiceUrl;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  User user;

  DeliveredDeliveryData(
      {this.id,
      this.orderId,
      this.userId,
      this.products,
      this.amount,
      this.deliveryCharge,
      this.deliveryAddress,
      this.packagerId,
      this.packager,
      this.deliveryManId,
      this.deliveryMan,
      this.paymentStatus,
      this.orderStatus,
      this.deliveryDate,
      this.invoiceUrl,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

  DeliveredDeliveryData.fromJson(Map<String, dynamic> json) {
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
    packager = json['packager'];
    deliveryManId = json['delivery_man_id'];
    deliveryMan = json['delivery_man'];
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
    data['packager'] = this.packager;
    data['delivery_man_id'] = this.deliveryManId;
    data['delivery_man'] = this.deliveryMan;
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
  String storeName;
  String email;
  String mobileNo;
  String alternateNo;
  String password;
  String address;
  String landmark;
  String state;
  String pincode;
  dynamic deliveryCharge;
  String deliveryDay;
  String latitude;
  String longitude;
  List<dynamic> favorites;
  bool isActive;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.storeName,
      this.email,
      this.mobileNo,
      this.alternateNo,
      this.password,
      this.address,
      this.landmark,
      this.state,
      this.pincode,
      this.deliveryCharge,
      this.deliveryDay,
      this.latitude,
      this.longitude,
      this.favorites,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeName = json['store_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    alternateNo = json['alternate_no'];
    password = json['password'];
    address = json['address'];
    landmark = json['landmark'];
    state = json['state'];
    pincode = json['pincode'];
    deliveryCharge = json['delivery_charge'];
    deliveryDay = json['delivery_day'];
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
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['alternate_no'] = this.alternateNo;
    data['password'] = this.password;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['delivery_charge'] = this.deliveryCharge;
    data['delivery_day'] = this.deliveryDay;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['favorites'] = this.favorites;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
