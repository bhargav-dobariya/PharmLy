// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) => GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  GetCartModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  Data? data;
  bool? success;

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
    code: json["code"],
    data: Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "success": success,
  };
}

class Data {
  Data({
    this.cartId,
    this.totalPriceOfCart,
    this.productData,
  });

  String? cartId;
  String? totalPriceOfCart;
  List<ProductDatum>? productData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cartId: json["cartId"],
    totalPriceOfCart: json["totalPriceOfCart"],
    productData: List<ProductDatum>.from(json["productData"].map((x) => ProductDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cartId": cartId,
    "totalPriceOfCart": totalPriceOfCart,
    "productData": List<dynamic>.from(productData!.map((x) => x.toJson())),
  };
}

class ProductDatum {
  ProductDatum({
    this.quantity,
    this.product,
  });

  int? quantity;
  Product? product;

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
    quantity: json["quantity"],
    product: Product.fromJson(json["Product"]),
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "Product": product?.toJson(),
  };
}

class Product {
  Product({
    this.id,
    this.title,
    this.companyName,
    this.price,
    this.productImage,
  });

  String? id;
  String? title;
  String? companyName;
  String? price;
  String? productImage;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    companyName: json["companyName"],
    price: json["price"],
    productImage: json["productImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "companyName": companyName,
    "price": price,
    "productImage": productImage,
  };
}
