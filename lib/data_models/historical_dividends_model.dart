import 'dart:convert';

class HistoricalDividends {
  List<Item>? items;
  String? nextPagePath;

  HistoricalDividends({
    this.items,
    this.nextPagePath,
  });

  factory HistoricalDividends.fromRawJson(String str) => HistoricalDividends.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoricalDividends.fromJson(Map<String, dynamic> json) => HistoricalDividends(
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    nextPagePath: json["nextPagePath"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "nextPagePath": nextPagePath,
  };
}

class Item {
  String? ticker;
  String? reference;
  double? quantity;
  double? amount;
  double? grossAmountPerShare;
  double? amountInEuro;
  DateTime? paidOn;
  String? type;

  Item({
    this.ticker,
    this.reference,
    this.quantity,
    this.amount,
    this.grossAmountPerShare,
    this.amountInEuro,
    this.paidOn,
    this.type,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    ticker: json["ticker"]?? 'N/A',
    reference: json["reference"] ?? 'N/A',
    quantity: json["quantity"]?.toDouble() ?? 0,
    amount: json["amount"]?.toDouble() ??0,
    grossAmountPerShare: json["grossAmountPerShare"]?.toDouble()??0,
    amountInEuro: json["amountInEuro"]?.toDouble()??0,
    paidOn: json["paidOn"] == null ? null : DateTime.parse(json["paidOn"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "ticker": ticker,
    "reference": reference,
    "quantity": quantity,
    "amount": amount,
    "grossAmountPerShare": grossAmountPerShare,
    "amountInEuro": amountInEuro,
    "paidOn": paidOn?.toIso8601String(),
    "type": type,
  };
}
