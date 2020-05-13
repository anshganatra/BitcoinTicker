import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:flutter_sparkline/flutter_sparkline.dart';

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
        child: Text(currency),
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
        //print(coinValues);
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
          history: (crypto == 'BTC')
              ? btchistory
              : (crypto == 'LTC') ? ltchistory : ethhistory,
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  DataColumn makeDataColumns(String inputLable) {
    return DataColumn(
        label: Text(
      inputLable,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11.0,
        fontFamily: 'Oxygen',
        //fontWeight: FontWeight.w200,
        letterSpacing: 2,
        color: Colors.grey.shade300,
      ),
    ));
  }

  DataCell renderDataCell({@required String dataCellLabel, String imageName}) {
    if (imageName != null) {
      return DataCell(Row(
        children: <Widget>[
          Image.asset(
            'images/$imageName.png',
            width: 22.0,
            height: 22.0,
          ),
          SizedBox(width: 15.0),
          Text(
            dataCellLabel,
            //textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ],
      ));
    } else {
      return DataCell(
        Text(
          dataCellLabel,
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Oxygen',
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  DataRow renderDataRow(String crypto) {
    return DataRow(cells: [
      renderDataCell(dataCellLabel: 'BTC', imageName: 'BTC'),
      renderDataCell(dataCellLabel: '123'),
      renderDataCell(dataCellLabel: '456'),
      renderDataCell(dataCellLabel: '789'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'the bitcoin project',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Oxygen'),
        )),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            height: 89.0,
            alignment: Alignment(0.7, 1),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'CURRENCY',
                  style: TextStyle(
                    fontSize: 18.0,
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
          makeCards(),
          // DataTable(columnSpacing: 0.0, columns: [
          //   makeDataColumns('    CRYPTO'),
          //   makeDataColumns('CURR'),
          //   makeDataColumns('    AVG'),
          //   makeDataColumns('% CHANGE'),
          // ], rows: [
          //   renderDataRow('BTC'),
          // ])
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
      this.history});

  final String value;
  final String average;
  final String percent;
  final String selectedCurrency;
  final String cryptoCurrency;
  final List<double> history;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            Image.asset(
              'images/$cryptoCurrency.png',
              height: 70.0,
              width: 70.5,
            ),
            new Sparkline(
              fallbackHeight: 75.0,
              fallbackWidth: 90.0,
              data: history,
              fillMode: FillMode.below,
              fillGradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[800], Colors.blue[200]],
              ),
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
                Text('CHANGE: $percent'),
                Text('AVG: $average'),
              ],
            )
          ],
        ));

    // return Card(
    //   color: Colors.black54,
    //   elevation: 5.0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
    //     child: Text(
    //       '1 $cryptoCurrency = $value $selectedCurrency',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 20.0,
    //         fontFamily: 'Oxygen',
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
  }
}
