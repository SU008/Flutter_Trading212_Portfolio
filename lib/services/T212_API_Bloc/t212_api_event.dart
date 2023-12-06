part of 't212_api_bloc.dart';

//action events like buttons

@immutable
abstract class T212ApiEvent {}

class GetAccountDataEvent extends T212ApiEvent {}
class GetAccountDataEventModel extends T212ApiEvent {}


class GetPersonalPortfolioEvent extends T212ApiEvent {}

class GetHistoricalItemsEvent extends T212ApiEvent {}


class GetPaidOutDividendsEvent extends T212ApiEvent {}
class GetPaidOutDividendsEventModel extends T212ApiEvent {}


class FetchDataOpenPositionsEvent1 extends T212ApiEvent {}