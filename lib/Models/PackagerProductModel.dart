class PackagerProductModel {
  List<PackagerProductData> data;

  PackagerProductModel({this.data});

  PackagerProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PackagerProductData>();
      json['data'].forEach((v) {
        data.add(new PackagerProductData.fromJson(v));
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

class PackagerProductData {
  int id;
  dynamic pickupId;
  dynamic wholesalerId;
  List<Products> products;
  dynamic amount;
  String pickupStatus;
  String deliveryCode;
  dynamic employeeId;
  String employeeName;
  String pickupAddress;
  String pickupDate;
  dynamic latitude;
  dynamic longitude;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  Wholesaler wholesaler;
  Employee employee;

  PackagerProductData(
      {this.id,
      this.pickupId,
      this.wholesalerId,
      this.products,
      this.amount,
      this.pickupStatus,
      this.deliveryCode,
      this.employeeId,
      this.employeeName,
      this.pickupAddress,
      this.pickupDate,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.wholesaler,
      this.employee});

  PackagerProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupId = json['pickup_id'];
    wholesalerId = json['wholesaler_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    amount = json['amount'];
    pickupStatus = json['pickup_status'];
    deliveryCode = json['delivery_code'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    pickupAddress = json['pickup_address'];
    pickupDate = json['pickup_date'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    wholesaler = json['wholesaler'] != null
        ? new Wholesaler.fromJson(json['wholesaler'])
        : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_id'] = this.pickupId;
    data['wholesaler_id'] = this.wholesalerId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['pickup_status'] = this.pickupStatus;
    data['delivery_code'] = this.deliveryCode;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['pickup_address'] = this.pickupAddress;
    data['pickup_date'] = this.pickupDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.wholesaler != null) {
      data['wholesaler'] = this.wholesaler.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee.toJson();
    }
    return data;
  }
}

class Products {
  int productId;
  String title;
  dynamic rate;
  dynamic noOfUnits;
  dynamic amount;

  Products(
      {this.productId, this.title, this.rate, this.noOfUnits, this.amount});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    rate = json['rate'];
    noOfUnits = json['no_of_units'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['rate'] = this.rate;
    data['no_of_units'] = this.noOfUnits;
    data['amount'] = this.amount;
    return data;
  }
}

class Wholesaler {
  int id;
  String name;
  String email;
  String mobileNo;
  dynamic alternateNo;
  String password;
  String address;
  String landmark;
  String state;
  String pincode;
  dynamic pendingAmount;
  dynamic latitude;
  dynamic longitude;
  bool isActive;
  String createdAt;
  String updatedAt;

  Wholesaler(
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
      this.pendingAmount,
      this.latitude,
      this.longitude,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Wholesaler.fromJson(Map<String, dynamic> json) {
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
    pendingAmount = json['pending_amount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['pending_amount'] = this.pendingAmount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Employee {
  dynamic id;
  String name;
  String email;
  String mobileNo;
  String password;
  dynamic aadhaarNo;
  dynamic driverLicense;
  String category;
  String address;
  dynamic pincode;
  dynamic createdAt;
  String updatedAt;

  Employee(
      {this.id,
      this.name,
      this.email,
      this.mobileNo,
      this.password,
      this.aadhaarNo,
      this.driverLicense,
      this.category,
      this.address,
      this.pincode,
      this.createdAt,
      this.updatedAt});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    aadhaarNo = json['aadhaar_no'];
    driverLicense = json['driver_license'];
    category = json['category'];
    address = json['address'];
    pincode = json['pincode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['password'] = this.password;
    data['aadhaar_no'] = this.aadhaarNo;
    data['driver_license'] = this.driverLicense;
    data['category'] = this.category;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
