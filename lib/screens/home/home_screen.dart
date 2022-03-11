import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toyota_app/models/current_price_model.dart';
import 'package:toyota_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Timer? timer;

  bool _isFetchingData = true;

  final List<CurrentPrice> _currentPrices = [];

  final ApiService _provider = ApiService();

  @override
  initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => _getStartup());

    _getStartup();
  }

  // make api call to fetch data
  void _getStartup() async {
    var results = await _provider.getCurrentPrice();

    CurrentPrice item = CurrentPrice.fromJson(results);

    _currentPrices.add(item);

    setState(() {
      _isFetchingData = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isFetchingData ? Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 2.0,
              ),
            ),
          ],
        ),
      ) : Container(
        color: const Color(0xff1A3036),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _currentPrices.length + 1,
                    itemBuilder: (_, i) {

                      if (i == 0) {
                        return Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentPrices[i].chartName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32.0
                                    ),
                                  ),
                                  Text(
                                    "updated last: ${_currentPrices[0].time['updated'].substring(0, _currentPrices[0].time['updated'].length - 3)}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0, top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          _currentPrices[i - 1].bpi['USD']['description'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: 20.0
                                          ),
                                        ),
                                        Text(
                                          _currentPrices[i - 1].bpi['USD']['code'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0
                                          ),
                                        ),
                                        Text(
                                          "\$${_currentPrices[i - 1].bpi['USD']['rate']}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          _currentPrices[i - 1].bpi['EUR']['description'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: 20.0
                                          ),
                                        ),
                                        Text(
                                          _currentPrices[i - 1].bpi['EUR']['code'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0
                                          ),
                                        ),
                                        Text(
                                          "€${_currentPrices[i - 1].bpi['EUR']['rate']}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          _currentPrices[i - 1].bpi['GBP']['description'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: 20.0
                                          ),
                                        ),
                                        Text(
                                          _currentPrices[i - 1].bpi['GBP']['code'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0
                                          ),
                                        ),
                                        Text(
                                          "£${_currentPrices[i - 1].bpi['GBP']['symbol'] == '&euro;' ? '' : ''}${_currentPrices[i - 1].bpi['GBP']['rate']}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

