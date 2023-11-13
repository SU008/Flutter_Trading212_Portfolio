import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../data_models/account_cash_model.dart';
import '../services/T212_API_Bloc/t212_api_bloc.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


//testing with model
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final T212ApiBloc T212apibloc = BlocProvider.of<T212ApiBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trading 212 Portfolio'),
      ),
      body: Card(

        elevation: 5, // Optional: Add elevation for a shadow effect
        color: Colors.blue[200],
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(15.0), // Adjust the radius as needed
        ),
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<T212ApiBloc, T212ApiState>(
            builder: (context, state) {
              if (state is ErrorState){
                const Center(child: Text('Error while fetch data'));
              }

              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PersonalPortfolioLoadedStateModel) {
                AccountCash accountcash = state.data;

                print(accountcash);
                return  Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Values shown are all approximate*', textScaleFactor: 0.8,),
                        ],
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12.0), // Adjust the radius as needed
                      ),
                      child: SizedBox(
                        height: 90,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Account Value : ${accountcash.total}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Portfolio : ${accountcash.invested.toDouble() + accountcash.ppl.toDouble()}'),
                                      Text('Invested : ${accountcash.invested }'),

                                    ],
                                  ),
                                  Column(

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Free Funds : ${accountcash.free} '),
                                      Text('Profit/Loss : ${accountcash.ppl} '),

                                    ],

                                  ),
                                ],

                              )




                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );


              } else {
                return const Center(
                    child: Text('Enter API Key/Press the button to fetch data'));
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          T212apibloc.add(GetAccountDataEventModel());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}





/*
//not data model
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final T212ApiBloc T212apibloc = BlocProvider.of<T212ApiBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trading 212 Portfolio'),
      ),
      body: Card(

        elevation: 5, // Optional: Add elevation for a shadow effect
        color: Colors.blue[200],
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(15.0), // Adjust the radius as needed
        ),
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<T212ApiBloc, T212ApiState>(
            builder: (context, state) {
              if (state is ErrorState){
                const Center(child: Text('Error while fetch data'));
              }

              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PersonalPortfolioLoadedState) {
                Map<String, dynamic> data = state.data;
                final total = data['total']?.toString() ?? 0.0;
                final free = data['free']?.toString() ?? 0.0;
                final invested = data['invested']?.toDouble() ?? 0.0;
                final ppl = data['ppl']?.toDouble() ?? 0.0;
                final portfolio =  NumberFormat('0.00').format(invested + ppl);

                print(data);
                return  Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Values shown are all approximate*', textScaleFactor: 0.8,),
                        ],
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12.0), // Adjust the radius as needed
                      ),
                      child: SizedBox(
                        height: 90,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Account Value : ${total}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Portfolio : ${portfolio} '),
                                      Text('Invested : ${invested } '),

                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Free Funds : ${free} '),
                                      Text('Return P/L : ${ppl} '),

                                    ],

                                  ),
                                ],

                              )




                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );


              } else {
                return const Center(
                    child: Text('Enter API Key/Press the button to fetch data'));
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          T212apibloc.add(GetAccountDataEvent());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}


 */





