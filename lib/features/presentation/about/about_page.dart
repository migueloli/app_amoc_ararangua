import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AMOC',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          )
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Desenvolvido por Shared Exp.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 10,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }

}