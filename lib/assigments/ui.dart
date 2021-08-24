import 'package:chat_app/assigments/model.dart';
import 'package:chat_app/assigments/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(builder: (context, provider, x) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              (provider.countries == null)?Container():DropdownButton<CountryModel>(
                  onChanged: (x) {
                    provider.selectCountry(x);
                  },
                  items: provider.countries
                      .map((e) => DropdownMenuItem<CountryModel>(
                            child: Text(e.name),
                            value: e,
                          ))
                      .toList()),
              (provider.cities == null)?Container():DropdownButton<dynamic>(
                  onChanged: (x) {
                    provider.selectCity(x);
                  },
                  items: provider.cities
                      .map((e) => DropdownMenuItem<CountryModel>(
                    child: Text(e.toString()),
                    value: e,
                  ))
                      .toList()),
            ],
          ),
        ),
      );
    });
  }
}
