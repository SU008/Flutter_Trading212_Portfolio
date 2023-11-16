import 'dart:convert';


class OpenPositionsList {
  final List<OpenPosition> openPositions;

  OpenPositionsList({required this.openPositions});

  factory OpenPositionsList.fromJson(List<dynamic> json) {
    List<OpenPosition> positions = json.map((data) => OpenPosition.fromJson(data)).toList();
    return OpenPositionsList(openPositions: positions);
  }

  Map<String, dynamic> toJson() {
    return {
      'openPositions': openPositions.map((position) => position.toJson()).toList(),
    };
  }
}

class OpenPosition {
  final String? ticker;
  final double? quantity;
  final double? averagePrice;
  final double? currentPrice;
  final double? ppl;
  final double? fxPpl;
  final DateTime? initialFillDate;

  final double? maxBuy;
  final double? maxSell;
  final double? pieQuantity;

  OpenPosition({
    this.ticker,
    this.quantity,
    this.averagePrice,
    this.currentPrice,
    this.ppl,
    this.fxPpl,
    this.initialFillDate,

    this.maxBuy,
    this.maxSell,
    this.pieQuantity,
  });

  factory OpenPosition.fromJson(Map<String, dynamic> json) {
    return OpenPosition(
      ticker: json['ticker'],
      quantity: json['quantity']?.toDouble(),
      averagePrice: json['averagePrice']?.toDouble(),
      currentPrice: json['currentPrice']?.toDouble(),
      ppl: json['ppl']?.toDouble(),
      fxPpl: json['fxPpl']?.toDouble(),
      initialFillDate: json['initialFillDate'] == null
          ? null
          : DateTime.parse(json['initialFillDate']),

      maxBuy: json['maxBuy']?.toDouble(),
      maxSell: json['maxSell'],
      pieQuantity: json['pieQuantity']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticker': ticker,
      'quantity': quantity,
      'averagePrice': averagePrice,
      'currentPrice': currentPrice,
      'ppl': ppl,
      'fxPpl': fxPpl,
      'initialFillDate': initialFillDate?.toIso8601String(),

      'maxBuy': maxBuy,
      'maxSell': maxSell,
      'pieQuantity': pieQuantity,
    };
  }
}





