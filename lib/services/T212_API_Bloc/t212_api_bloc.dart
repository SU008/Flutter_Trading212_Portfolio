import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;


part 't212_api_event.dart';
part 't212_api_state.dart';

class T212ApiBloc extends Bloc<T212ApiEvent, T212ApiState> {

  final Throttle throttle = Throttle(const Duration(seconds: 1), initialValue: ''); // 1 call per second


  T212ApiBloc() : super(T212ApiInitial()) {

    on<GetAccountDataEvent>(_getAccountDataEvent);


  }

  void _getAccountDataEvent(GetAccountDataEvent event, Emitter<T212ApiState> emit) async {
    String tempAPI_key = 'YOur_Key';

    print('hello');

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

      //final AccountCash myaccountcash = json.decode(response.body) as AccountCash;




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






