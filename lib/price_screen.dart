import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  PriceScreen({this.getJesonData});
  final getJesonData;
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coindat = CoinData();
  String newDropdownValue = 'USD';
  int SelectedCupertinoValue = 1;
  double BtcToUsd = 0.0;
  var jsonData;

// for android dropdown
  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> allDropdownItem = [];
    DropdownMenuItem<String> item;
    for (String curenci in currenciesList) {
      item = DropdownMenuItem(
        child: Text(curenci),
        value: curenci,
      );
      allDropdownItem.add(item);
    }
    return DropdownButton(
      value: newDropdownValue,
      dropdownColor: Colors.lightBlue,
      onChanged: (value) async {
        var UpdateJeson;
        UpdateJeson = await coindat.getDataFromAPI(value);
        setState(() {
          UpdatUI(UpdateJeson);
          newDropdownValue = value;
        });
      },
      items: allDropdownItem,
    );
  }

//for Ios Cupertinostyle
  CupertinoPicker getIosCupertino() {
    List<Widget> allCupertinoItem = [];
    Widget item;
    for (String curenci in currenciesList) {
      item = Text(
        curenci,
        style: TextStyle(color: Colors.white),
      );
      allCupertinoItem.add(item);
    }

    return CupertinoPicker(
      onSelectedItemChanged: (value) {
        SelectedCupertinoValue = value;
      },
      children: allCupertinoItem,
      itemExtent: 50,
    );
  }

  void UpdatUI(coindata) {
    setState(() {
      if (coindata == null) {
        print("can't get data from Api");
      } else {
        BtcToUsd = coindata['rate'];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //UpdatUI(widget.getJesonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${BtcToUsd.toStringAsFixed(2)} $newDropdownValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? getIosCupertino() : getAndroidDropdown()),
        ],
      ),
    );
  }
}
