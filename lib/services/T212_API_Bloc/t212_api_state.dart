part of 't212_api_bloc.dart';


// things that are returned
@immutable
abstract class T212ApiState {}

class T212ApiInitial extends T212ApiState {}

class LoadingState extends T212ApiState {}
class ErrorState extends T212ApiState {}


//--------------------------
class PersonalPortfolioLoadedState extends T212ApiState {
  final Map<String, dynamic> data;

  PersonalPortfolioLoadedState(this.data);
}

//usind data model as return type
class PersonalPortfolioLoadedStateModel extends T212ApiState {
  final AccountCash data;

  PersonalPortfolioLoadedStateModel(this.data);
}
//---------------------------


//-------dividend chart---------------
class PaidOutDividendsState extends T212ApiState {
  final Map<String, dynamic> data;

  PaidOutDividendsState(this.data);
}

class PaidOutDividendsStateModel extends T212ApiState {
  final HistoricalDividends data;

  PaidOutDividendsStateModel(this.data);
}
//-----------------------------------


//--openpositions
class DataLoadedOpenPositionsState90 extends T212ApiState {
  final OpenPositionsList data;

  DataLoadedOpenPositionsState90(this.data);
}