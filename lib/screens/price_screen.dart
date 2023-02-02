import 'package:flutter/material.dart';
import '../data/coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var selectedcurrency = 'USD';
  int rate = 1;
  String currency = '';

  var knewURL =
      'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$kApikey';

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String curr in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(curr), value: curr);
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedcurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedcurrency = value!;
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String curr in currenciesList) {
      pickerItems.add(Text(curr));
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlueAccent,
        itemExtent: 30,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            getData();
            selectedcurrency = currenciesList[selectedIndex];
            knewURL =
                'https://rest.coinapi.io/v1/exchangerate/BTC/${currenciesList[selectedIndex]}?apikey=$kApikey';
          });
        },
        children: pickerItems);
  }

  void getData() async {
    CoinData coinData = CoinData();
    double data = await coinData.getCoinData(selectedcurrency);
    setState(() {
      rate = data.toInt();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💰 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC =  ${rate.toString()} $selectedcurrency ',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                color: Colors.lightBlueAccent,
                height: 150.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30.0),
                child: iOSPicker()),
          )
        ],
      ),
    );
  }
}
