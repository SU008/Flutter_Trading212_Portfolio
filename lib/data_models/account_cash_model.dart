import 'dart:convert';
//https://app.quicktype.io/
class AccountCash {
  int blocked;
  int free;
  int invested;
  int pieCash;
  int ppl;
  int result;
  int total;

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
    blocked: json["blocked"],
    free: json["free"],
    invested: json["invested"],
    pieCash: json["pieCash"],
    ppl: json["ppl"],
    result: json["result"],
    total: json["total"],
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
