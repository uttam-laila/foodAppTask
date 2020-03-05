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
    for (var i = 0; i < response[0]['table_menu_list'].length; i++) {
      choices.add(Choice(
          title: response[0]['table_menu_list'][i]['menu_category'], index: i));
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
            indicatorColor: Colors.red,
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  choice.title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: EdgeInsets.all(16.0),
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
    return ListView.builder(
        itemCount: response[0]['table_menu_list'][choice.index]
                ['category_dishes']
            .length,
        itemBuilder: (BuildContext context, int index) {
          final TextStyle textStyle = Theme.of(context).textTheme.headline6;
          var data =
              response[0]['table_menu_list'][choice.index]['category_dishes'];
          return Container(
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(flex: 1, child: Image.asset('assets/icons/nvicon.png', color: Colors.green,)),
                            Expanded(
                                flex: 10, child: Text(data[index]['dish_name']))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(),
                            Container(),
                          ],
                        ),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 150,
                    child: Image.network(
                      data[index]['dish_image'],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
