import 'dart:convert';

import 'package:intl/intl.dart';

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
    ticker: json["ticker"]!= null ? _formatTicker(json["ticker"]) : 'N/A',
    reference: json["reference"] ?? 'N/A',
    quantity: json["quantity"]?.toDouble() ?? 0,
    amount: json["amount"]?.toDouble() ??0,
    grossAmountPerShare: json["grossAmountPerShare"]?.toDouble()??0,
    amountInEuro: json["amountInEuro"]?.toDouble()??0,
    paidOn: json["paidOn"] == null ? null : DateFormat('yyyy-MM-dd').parse(json["paidOn"]),
    type: json["type"],
  );

  // Helper method to format date with only year, month, and day
  //paidOn: json["paidOn"] == null ? null : formatDateTime(DateTime.parse(json["paidOn"])),
  static DateTime formatDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      // Create a new DateTime with only the date part


      final newDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);

      return newDateTime;
    } else {
      // Return null if the input is null
      return DateTime(0, 0, 0);
    }
  }



  // Helper method to format the ticker symbol
  static String _formatTicker(String ticker) {
    if (ticker.contains('_')) {
      return ticker.split('_')[0];
    } else {
      return ticker;
    }
  }

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

/*
//before formatting
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
 */