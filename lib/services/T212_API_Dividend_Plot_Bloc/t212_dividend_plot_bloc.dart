import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

//--------------Events
@immutable
abstract class ApiEvent {}

class FetchDataEvent extends ApiEvent {}
//-------------------------------------

//--------------States
@immutable
abstract class ApiState {}

class InitialState extends ApiState {}

class LoadingState extends ApiState {}

class DataLoadedState extends ApiState {
  final List<dynamic> data;

  DataLoadedState(this.data);
}

class ErrorState extends ApiState {
  final String error;

  ErrorState(this.error);
}
//--------------------------

// BLoC
class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final String apiUrl;

  ApiBloc(this.apiUrl) : super(InitialState()) {
    // Register the event handler for FetchDataEvent
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  // Event handler for FetchDataEvent
  void _onFetchDataEvent(FetchDataEvent event, Emitter<ApiState> emit) async {
    emit(LoadingState());


    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        emit(DataLoadedState(data));
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (error) {
      emit(ErrorState("Failed to fetch data"));
    }
  }


}
