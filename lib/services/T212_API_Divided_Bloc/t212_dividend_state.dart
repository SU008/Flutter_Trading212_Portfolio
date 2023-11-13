part of 't212_dividend_bloc.dart';

@immutable
abstract class T212DividendState {}

class T212DividendInitial extends T212DividendState {}

class LoadingState2 extends T212DividendState {}


class PaidOutDividendsStateModel2 extends T212DividendState {
  final HistoricalDividends data;

  PaidOutDividendsStateModel2(this.data);
}