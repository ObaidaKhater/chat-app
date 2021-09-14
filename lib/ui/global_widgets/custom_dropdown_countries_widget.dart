import 'package:chat_app/models/country_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdownCountriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context,provider,x){
      return  (provider.countries == null)
          ? Text('loading ...')
          : DropdownButton<CountryModel>(
          isExpanded: true,
          value: provider.countryValue,
          style: Theme.of(context).textTheme.bodyText1,
          onChanged: (newCountry) =>
              provider.selectCountry(newCountry),
          items: provider.countries.map((country) {
            return DropdownMenuItem<CountryModel>(
              value: country,
              child: Text(country.name),
            );
          }).toList());
    });
  }
}
