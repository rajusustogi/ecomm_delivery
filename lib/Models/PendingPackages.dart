import 'CompletePackager.dart';

class PendingPackages {
  List<PendingPackagesData> data;

  PendingPackages({this.data});

  PendingPackages.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PendingPackagesData>();
      json['data'].forEach((v) {
        data.add(new PendingPackagesData.fromJson(v));
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

class PendingPackagesData {
  int id;
  dynamic orderId;
  dynamic userId;
  dynamic cartId;
  List<Products> products;
  dynamic amount;
  dynamic deliveryCharge;
  String deliveryAddress;
  dynamic deliveryManId;
  dynamic packagerId;
  String deliveryCode;
  String paymentStatus;
  String orderStatus;
  List<Products> pendingProducts;
  List<Products> completeProducts;
  String expectedDate;
  dynamic invoiceUrl;
  String latitude;
  String longitude;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  User user;

  PendingPackagesData(
      {this.id,
      this.orderId,
      this.userId,
      this.cartId,
      this.products,
      this.amount,
      this.deliveryCharge,
      this.deliveryAddress,
      this.deliveryManId,
      this.packagerId,
      this.deliveryCode,
      this.paymentStatus,
      this.orderStatus,
      this.pendingProducts,
      this.completeProducts,
      this.expectedDate,
      this.invoiceUrl,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

  PendingPackagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    cartId = json['cart_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    amount = json['amount'];
    deliveryCharge = json['delivery_charge'];
    deliveryAddress = json['delivery_address'];
    deliveryManId = json['delivery_man_id'];
    packagerId = json['packager_id'];
    deliveryCode = json['delivery_code'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    if (json['pending_products'] != null) {
      pendingProducts = new List<Products>();
      json['pending_products'].forEach((v) {
        pendingProducts.add(new Products.fromJson(v));
      });
    }
    if (json['completed_products'] != null) {
      completeProducts = new List<Products>();
      json['completed_products'].forEach((v) {
        completeProducts.add(new Products.fromJson(v));
      });
    }
    expectedDate = json['expected_date'];
    invoiceUrl = json['invoice_url'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['cart_id'] = this.cartId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['delivery_charge'] = this.deliveryCharge;
    data['delivery_address'] = this.deliveryAddress;
    data['delivery_man_id'] = this.deliveryManId;
    data['packager_id'] = this.packagerId;
    data['delivery_code'] = this.deliveryCode;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    if (this.pendingProducts != null) {
      data['pending_products'] =
          this.pendingProducts.map((v) => v.toJson()).toList();
    }
    data['expected_date'] = this.expectedDate;
    data['invoice_url'] = this.invoiceUrl;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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
