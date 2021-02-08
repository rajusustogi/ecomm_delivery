class InvoiceDeliveryModel {
  List<Data> data;

  InvoiceDeliveryModel({this.data});

  InvoiceDeliveryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  List<CompactHistory> compactHistory;
  dynamic date;
  dynamic totalOrders;
  dynamic totalAmount;

  Data({this.compactHistory, this.date, this.totalOrders, this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['compact_history'] != null) {
      compactHistory = new List<CompactHistory>();
      json['compact_history'].forEach((v) {
        compactHistory.add(new CompactHistory.fromJson(v));
      });
    }
    date = json['date'];
    totalOrders = json['total_orders'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.compactHistory != null) {
      data['compact_history'] =
          this.compactHistory.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['total_orders'] = this.totalOrders;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class CompactHistory {
  dynamic orderId;
  dynamic retailerName;
  dynamic address;
  dynamic amount;

  CompactHistory({this.orderId, this.retailerName, this.address, this.amount});

  CompactHistory.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    retailerName = json['retailer_name'];
    address = json['address'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['retailer_name'] = this.retailerName;
    data['address'] = this.address;
    data['amount'] = this.amount;
    return data;
  }
}
