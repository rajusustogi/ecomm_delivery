class User {
  String token;
  Data data;

  User({this.token, this.data});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  String mobileNo;
  String password;
  String aadhaarNo;
  dynamic driverLicense;
  String categoryId;
  String address;
  dynamic pincode;
  dynamic createdBy;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.mobileNo,
      this.password,
      this.aadhaarNo,
      this.driverLicense,
      this.categoryId,
      this.address,
      this.pincode,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    aadhaarNo = json['aadhaar_no'];
    driverLicense = json['driver_license'];
    categoryId = json['category'];
    address = json['address'];
    pincode = json['pincode'];
    createdBy = json['created_by'];
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
    data['category'] = this.categoryId;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
