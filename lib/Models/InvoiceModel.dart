class InvoiceModel {
  List<InvoiceData> data;

  InvoiceModel({this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<InvoiceData>();
      json['data'].forEach((v) {
        data.add(new InvoiceData.fromJson(v));
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

class InvoiceData {
  List<CompactPickups> compactPickups;
  dynamic date;

  InvoiceData({this.compactPickups, this.date});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    if (json['compactPickups'] != null) {
      compactPickups = new List<CompactPickups>();
      json['compactPickups'].forEach((v) {
        compactPickups.add(new CompactPickups.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.compactPickups != null) {
      data['compactPickups'] =
          this.compactPickups.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class CompactPickups {
  dynamic pickupId;
  String wholesalerName;
  dynamic items;
  dynamic paidAmount;

  CompactPickups(
      {this.pickupId, this.wholesalerName, this.items, this.paidAmount});

  CompactPickups.fromJson(Map<String, dynamic> json) {
    pickupId = json['pickup_id'];
    wholesalerName = json['wholesaler_name'];
    items = json['items'];
    paidAmount = json['paid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_id'] = this.pickupId;
    data['wholesaler_name'] = this.wholesalerName;
    data['items'] = this.items;
    data['paid_amount'] = this.paidAmount;
    return data;
  }
}
