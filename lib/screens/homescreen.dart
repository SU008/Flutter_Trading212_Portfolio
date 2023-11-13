import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portfolio_dividend/data_models/historical_dividends_model.dart';
import 'package:intl/intl.dart';
import '../data_models/account_cash_model.dart';
import '../services/T212_API_Bloc/t212_api_bloc.dart';
import '../services/T212_API_Divided_Bloc/t212_dividend_bloc.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//testing with model
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final T212ApiBloc T212apibloc = BlocProvider.of<T212ApiBloc>(context);
    final T212DividendBloc divbloc = BlocProvider.of<T212DividendBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trading 212 Portfolio'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShowAccountCash(),
            SizedBox(height: 5,),

            ShowHistoricalDividends(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          T212apibloc.add(GetAccountDataEventModel());

          await Future.delayed(const Duration(milliseconds: 1000),);

          divbloc.add(GetPaidOutDividendsEventModel2());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class ShowHistoricalDividends extends StatelessWidget {
  const ShowHistoricalDividends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Optional: Add elevation for a shadow effect
      color: Colors.blue[200],
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15.0), // Adjust the radius as needed
      ),
      child: Container(
        height: 600,
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<T212DividendBloc, T212DividendState>(
          builder: (context, state) {
            if (state is ErrorState) {
              const Center(child: Text('Error while fetch data'));
            }

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaidOutDividendsStateModel2) {
              HistoricalDividends divistory = state.data;

              return ListView.builder(
                itemCount: divistory.items?.length,
                itemBuilder: (context, index) {

                  Item dividend = divistory.items![index];
                  return ListTile(
                    leading: Text('${dividend.ticker}'),
                    title: Text('Amount: ${dividend.amountInEuro}'),
                    subtitle: Text('Date: ${dividend.paidOn}'),
                  );
                },
              );

            } else {
              return const Center(
                  child: Text(
                      'Enter API Key/Press the button to fetch data'));
            }
          },
        ),
      ),
    );
  }
}



class ShowAccountCash extends StatefulWidget {
  const ShowAccountCash({
    super.key,
  });

  @override
  State<ShowAccountCash> createState() => _ShowAccountCashState();
}
class _ShowAccountCashState extends State<ShowAccountCash> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Optional: Add elevation for a shadow effect
      color: Colors.blue[200],
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15.0), // Adjust the radius as needed
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<T212ApiBloc, T212ApiState>(
          builder: (context, state) {
            if (state is ErrorState) {
              const Center(child: Text('Error while fetch data'));
            }

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PersonalPortfolioLoadedStateModel) {
              AccountCash accountcash = state.data;
              num portfolio =
                  accountcash.invested.toDouble() + accountcash.ppl.toDouble();
              String myportfolio = portfolio.toStringAsFixed(2);

              print(accountcash);
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 8, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Values shown are all approximate*',
                          textScaleFactor: 0.8,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), // Adjust the radius as needed
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
                                Text('Account Value : ${accountcash.total}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Portfolio : ${myportfolio}'),
                                    Text('Invested : ${accountcash.invested}'),
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
    );
  }
}

