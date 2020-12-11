import 'package:demoapp/Components/custom-drawer.dart';
import 'package:demoapp/screens/pagetwo/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageTwoScreen extends StatefulWidget {
  @override
  _PageTwoScreenState createState() => _PageTwoScreenState();
}

class _PageTwoScreenState extends State<PageTwoScreen> {
  String state = "two";

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
        body: PageTwoBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Page Two"),
    );
  }
}
