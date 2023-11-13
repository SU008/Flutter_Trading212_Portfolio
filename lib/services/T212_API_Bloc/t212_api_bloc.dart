import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_portfolio_dividend/data_models/historical_dividends_model.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; //for .env file
import 'package:easy_debounce/easy_debounce.dart';//debounce


import '../../data_models/account_cash_model.dart';


part 't212_api_event.dart';
part 't212_api_state.dart';

class T212ApiBloc extends Bloc<T212ApiEvent, T212ApiState> {

  final Throttle throttle = Throttle(const Duration(milliseconds: 300), initialValue: ''); // 1 call per second


  T212ApiBloc() : super(T212ApiInitial()) {

    on<GetAccountDataEvent>(_getAccountDataEvent);
    on<GetAccountDataEventModel>(_getAccountDataEventModel);//useing data model

    on<GetPaidOutDividendsEventModel>(_getPaidOutDividendsEventModel);


  }

  void _getPaidOutDividendsEventModel(GetPaidOutDividendsEventModel event, Emitter<T212ApiState> emit) async {
    emit(LoadingState());

    await dotenv.load(); //done in main.dart instead
    String tempAPI_key = dotenv.env['API_KEY'] ?? "Your_API_Key_During_Testing";

    Map<String, String> queryParameters = {
      "limit": "50",
    };

    var target_headers = {
      "Authorization": tempAPI_key,
      "Content-Type":"application/json",
    };

    Uri theUrl = Uri.parse('https://live.trading212.com/api/v0/history/dividends').replace(queryParameters: queryParameters);

    print('the url is : $theUrl');
    final response = await http.get(theUrl, headers: target_headers); //sending a get
    print('dividends response code: ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        // Decode the JSON response into an instance of AccountCash

        Map<String, dynamic> data = json.decode(response.body);

        HistoricalDividends divhistory = HistoricalDividends.fromJson( json.decode(response.body));

        //final Map<String, dynamic> data = json.decode(response.body);
        print("Dividend map data: ${data}");
        print("Dividend map data: ${divhistory.items}");

        emit(PaidOutDividendsStateModel(divhistory));

      } else {
        emit(ErrorState());
        print('failed to fetch data');
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print('failed to fetch data [e]');
      emit(ErrorState());
      print("Error decoding JSON or handling response: $e");
    }






  }






  void _getAccountDataEventModel(GetAccountDataEventModel event, Emitter<T212ApiState> emit) async {

    await dotenv.load(); //done in main.dart instead
    String tempAPI_key = dotenv.env['API_KEY'] ?? "Your_API_Key_During_Testing";

    emit(LoadingState());
    var theUrl = Uri.parse('https://live.trading212.com/api/v0/equity/account/cash');

    var target_headers = {
      "Authorization": tempAPI_key,
      "Content-Type":"application/json",
    };

    final response = await http.get(theUrl, headers: target_headers); //sending a get
    //print(response.statusCode);
    try {
      if (response.statusCode == 200) {
      // Decode the JSON response into an instance of AccountCash
      final Map<String, dynamic> data = json.decode(response.body);
      print("map data: $data");

      AccountCash accountCash = AccountCash.fromJson(data);

      //print("AccountCash successfully decoded: $accountCash"); // Add this line

      emit(PersonalPortfolioLoadedStateModel(accountCash));
    } else {
      emit(ErrorState());
      print('failed to fetch data');
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  } catch (e) {
      print('failed to fetch data [e]');
      emit(ErrorState());
      print("Error decoding JSON or handling response: $e");
  }




  }



  void _getAccountDataEvent(GetAccountDataEvent event, Emitter<T212ApiState> emit) async {
    String tempAPI_key = '5035198ZLvgNiDKqcFzudYTVwdWnBEwCXsMU';

    emit(LoadingState());
    var theUrl = Uri.parse('https://live.trading212.com/api/v0/equity/account/cash');

    var target_headers = {
      "Authorization": tempAPI_key,
      "Content-Type":"application/json",
    };

    final response = await http.get(theUrl, headers: target_headers); //sending a get
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      emit(PersonalPortfolioLoadedState(data));

    } else {
      emit(ErrorState());
      throw Exception("Failed to fetch data");
    }

  }


}


/*
      try {
        await throttle.throttle(() {
          // Make your API call to www.database/profile here
        });

       // yield APICallSuccess();
      } catch (e) {

      }
    });


    on<T212ApiEvent>((event, emit) {
      // TODO: implement event handler
    });


 */






