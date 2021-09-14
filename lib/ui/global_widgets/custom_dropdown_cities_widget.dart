import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdownCitiesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context,provider,x){
      return (provider.cities == null)
          ? Text('loading ...')
          : DropdownButton<dynamic>(
          isExpanded: true,
          value: provider.cityValue,
          style: Theme.of(context).textTheme.bodyText1,
          onChanged: (newCity) =>
              provider.selectCity(newCity),
          items: provider.cities.map((city) {
            return DropdownMenuItem<dynamic>(
              value: city,
              child: Text(city.toString()),
            );
          }).toList());
    });
  }
}
