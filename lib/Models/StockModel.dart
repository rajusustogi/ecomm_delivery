class StockModel {
  List<StockData> data;

  StockModel({this.data});

  StockModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<StockData>();
      json['data'].forEach((v) {
        data.add(new StockData.fromJson(v));
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

class StockData {
  int id;
  dynamic productId;
  int noOfUnits;
  String status;
  dynamic orderId;  
  dynamic createdAt;
  String updatedAt;
  Product product;
  Order order;

  StockData(
      {this.id,
      this.productId,
      this.noOfUnits,
      this.status,
      this.orderId,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.order});

  StockData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    noOfUnits = json['no_of_units'];
    status = json['status'];
    orderId = json['order_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['no_of_units'] = this.noOfUnits;
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
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
  dynamic categoryId;
  dynamic mrp;
  dynamic offPercentage;
  dynamic offAmount;
  dynamic sellingPrice;
  bool isTrending;
  bool isActive;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

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
      this.updatedAt,
      this.deletedAt});

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
    deletedAt = json['deletedAt'];
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
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class Order {
  List<Products> products;
  List<Products> pendingProducts;
  dynamic id;
  dynamic orderId;
  dynamic userId;
  dynamic cartId;
  dynamic amount;
  dynamic deliveryCharge;
  String deliveryAddress;
  String latitude;
  String longitude;
  dynamic deliveryManId;
  dynamic packagerId;
  String deliveryCode;
  String paymentStatus;
  String orderStatus;
  String expectedDate;
  dynamic invoiceUrl;
  String createdAt;
  String updatedAt;

  Order(
      {this.products,
      this.pendingProducts,
      this.id,
      this.orderId,
      this.userId,
      this.cartId,
      this.amount,
      this.deliveryCharge,
      this.deliveryAddress,
      this.latitude,
      this.longitude,
      this.deliveryManId,
      this.packagerId,
      this.deliveryCode,
      this.paymentStatus,
      this.orderStatus,
      this.expectedDate,
      this.invoiceUrl,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    if (json['pending_products'] != null) {
      pendingProducts = new List<Products>();
      json['pending_products'].forEach((v) {
        pendingProducts.add(new Products.fromJson(v));
      });
    }
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    cartId = json['cart_id'];
    amount = json['amount'];
    deliveryCharge = json['delivery_charge'];
    deliveryAddress = json['delivery_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryManId = json['delivery_man_id'];
    packagerId = json['packager_id'];
    deliveryCode = json['delivery_code'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    expectedDate = json['expected_date'];
    invoiceUrl = json['invoice_url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.pendingProducts != null) {
      data['pending_products'] =
          this.pendingProducts.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['cart_id'] = this.cartId;
    data['amount'] = this.amount;
    data['delivery_charge'] = this.deliveryCharge;
    data['delivery_address'] = this.deliveryAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['delivery_man_id'] = this.deliveryManId;
    data['packager_id'] = this.packagerId;
    data['delivery_code'] = this.deliveryCode;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['expected_date'] = this.expectedDate;
    data['invoice_url'] = this.invoiceUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Products {
  dynamic productId;
  dynamic noOfUnits;
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
