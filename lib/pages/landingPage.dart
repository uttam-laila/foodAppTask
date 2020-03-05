import 'package:flutter/material.dart';
import 'package:foodapptask/consts/exports.dart';
import 'package:foodapptask/widgets/choice.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    List<Choice> choices = <Choice>[];
    for (var item in response[0]['table_menu_list']) {
      choices.add(Choice(title: item['menu_category']));
    }

    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Text(
                    'My Orders',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.shopping_cart, color: Colors.black),
                )
              ],
            ),
          ],
          title: Text(
            response[0]['restaurant_name'],
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  choice.title,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
