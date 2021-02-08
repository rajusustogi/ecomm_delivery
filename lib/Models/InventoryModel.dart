class InventoryModel {
  List<InventoryData> data;

  InventoryModel({this.data});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<InventoryData>();
      json['data'].forEach((v) {
        data.add(new InventoryData.fromJson(v));
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

class InventoryData {
  dynamic id;
  dynamic productId;
  int noOfUnits;
  String createdAt;
  String updatedAt;
  Product product;

  InventoryData(
      {this.id,
      this.productId,
      this.noOfUnits,
      this.createdAt,
      this.updatedAt,
      this.product});

  InventoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    noOfUnits = json['no_of_units'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['no_of_units'] = this.noOfUnits;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String title;
  String manufacturer;
  String packSize;
  String imageUrl;
  String composition;
  int categoryId;
  dynamic mrp;
  dynamic offPercentage;
  dynamic offAmount;
  dynamic sellingPrice;
  bool isTrending;
  bool isActive;
  String createdAt;
  String updatedAt;

  Product(
      {this.id,
      this.title,
      this.manufacturer,
      this.packSize,
      this.imageUrl,
      this.composition,
      this.categoryId,
      this.mrp,
      this.offPercentage,
      this.offAmount,
      this.sellingPrice,
      this.isTrending,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    manufacturer = json['manufacturer'];
    packSize = json['pack_size'];
    imageUrl = json['image_url'];
    composition = json['composition'];
    categoryId = json['category_id'];
    mrp = json['mrp'];
    offPercentage = json['off_percentage'];
    offAmount = json['off_amount'];
    sellingPrice = json['selling_price'];
    isTrending = json['is_trending'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['manufacturer'] = this.manufacturer;
    data['pack_size'] = this.packSize;
    data['image_url'] = this.imageUrl;
    data['composition'] = this.composition;
    data['category_id'] = this.categoryId;
    data['mrp'] = this.mrp;
    data['off_percentage'] = this.offPercentage;
    data['off_amount'] = this.offAmount;
    data['selling_price'] = this.sellingPrice;
    data['is_trending'] = this.isTrending;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
