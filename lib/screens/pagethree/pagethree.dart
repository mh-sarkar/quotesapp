import 'package:demoapp/Components/custom-drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/body.dart';

class PageThreeScreen extends StatefulWidget {
  @override
  _PageThreeScreenState createState() => _PageThreeScreenState();
}

class _PageThreeScreenState extends State<PageThreeScreen> {
  String state = "three";

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
        drawer: CustomDrawer(state: state,),
        appBar: buildAppBar(),
        body: PageThreeBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Page Three"),
    );
  }
}