import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

import 'crypto_details.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  //DropdownButton<String> androidDropdown() {
  androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency,
              style: TextStyle(fontSize: 22,),
              ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData();
          });
        },
      ),
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[crypto],
          average: isWaiting ? '?' : coinValues[crypto + '_AVERAGE'],
          percent: isWaiting ? '?' : coinValues[crypto + '_CHANGE'],
          percentDaily: isWaiting ? '?' : coinValues[crypto + '_PERCENT_DAILY'],
          percentMonthly: isWaiting ? '?' : coinValues[crypto + '_PERCENT_MONTHLY'],
          openDaily: isWaiting ? '?' : coinValues[crypto + '_OPEN'],
          high: isWaiting ? '?' : coinValues[crypto + '_DAY_HIGH'],
          low: isWaiting ? '?' : coinValues[crypto + '_DAY_LOW'],
          currency: isWaiting ? '?' : coinValues['currency'],
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'The CryptoCurrency Project',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Oxygen'),
        )),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.blue.shade600, Colors.purple.shade600],
              ),
            ),
            height: 70.0,
            alignment: Alignment(0.7, 1),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            padding: EdgeInsets.only(bottom: 15.0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'CURRENCY',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w100,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    Platform.isIOS ? iOSPicker() : androidDropdown(),
                  ],
                ),
          ),
          Text('For more details, tap on the cards below', style: TextStyle(),),
          makeCards(),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {this.value,
      this.average,
      this.percent,
      this.selectedCurrency,
      this.cryptoCurrency,
      this.percentDaily,
      this.percentMonthly,
      this.openDaily,
      this.high,
      this.low,
      this.currency,
      });

  final String value;
  final String average;
  final String percent;
  final String selectedCurrency;
  final String cryptoCurrency;
  final String percentDaily;
  final String percentMonthly;
  final String openDaily;
  final String high;
  final String low;
  final String currency;
  // final List<double> history;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
        MaterialPageRoute(
          builder: (context)=>ShowDetails(
            cryptoCurrency, percentDaily, percent, percentMonthly, openDaily, high, low, currency
          )
        )
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54, offset: Offset(10, 5), blurRadius: 10.0),
            BoxShadow(
                color: Colors.white10, offset: Offset(0, 5), blurRadius: 10.0)
          ],
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: "$cryptoCurrency"+"graph",
                  child: Image.asset(
                    'images/$cryptoCurrency.png',
                    height: 70.0,
                    width: 70.5,
                  ),
                ),
                Text('$cryptoCurrency',
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  '$selectedCurrency $value',
                  style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      'CHANGE: $percent', 
                      style: percent != '?'?
                      TextStyle(color: double.parse(percent)>0? Colors.lightGreenAccent :Colors.red)
                      : TextStyle(),
                    ),
                    percent != '?'?
                      double.parse(percent)>0 ?
                      Icon(Icons.arrow_drop_up, color: Colors.lightGreenAccent,): Icon(Icons.arrow_drop_down, color: Colors.red,):
                      Icon(null),
                  ],
                ),
                Text('AVG: $average'),
              ],
            )
          ],
        )
      )
    );
  }
}
