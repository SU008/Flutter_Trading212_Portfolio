import 'dart:convert';
//https://app.quicktype.io/




class AccountCash {
  final num blocked;
  final num free;
  final num invested;
  final num pieCash;
  final num ppl;
  final num result;
  final num total;

  AccountCash({
    required this.blocked,
    required this.free,
    required this.invested,
    required this.pieCash,
    required this.ppl,
    required this.result,
    required this.total,
  });

  factory AccountCash.fromRawJson(String str) => AccountCash.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountCash.fromJson(Map<String, dynamic> json) => AccountCash(
    blocked: json["blocked"] ?? 0 ,
    free: json["free"] ?? 0 ,
    invested: json["invested"] ?? 0 ,
    pieCash: json["pieCash"] ?? 0 ,
    ppl: json["ppl"] ?? 0 ,
    result: json["result"] ?? 0,
    total: json["total"] ?? 0 ,
  );

  Map<String, dynamic> toJson() => {
    "blocked": blocked,
    "free": free,
    "invested": invested,
    "pieCash": pieCash,
    "ppl": ppl,
    "result": result,
    "total": total,
  };
}


