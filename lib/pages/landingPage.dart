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
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  choice.title,
                  // style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return ChoiceCard(choice: choice);
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
          // final TextStyle textStyle = Theme.of(context).textTheme.headline6;
          var data =
              response[0]['table_menu_list'][choice.index]['category_dishes'];
          int _count = 0;
          return Card(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/icons/nvicon.png',
                      color: Colors.green,
                    )),
                Expanded(
                    flex: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 10, child: Text(data[index]['dish_name']))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                  '${data[index]['dish_currency']} ${data[index]['dish_price']}'),
                            ),
                            Container(
                              child: Text(
                                  '${data[index]['dish_calories']} Calories'),
                            ),
                          ],
                        ),
                        Container(
                          child: Text('${data[index]['dish_description']}'),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 25,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: new BoxDecoration(
                              color: Colors
                                  .green, //new Color.fromRGBO(255, 0, 0, 0.0),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(40.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                child: Text('+'),
                                onTap: () => _count++,
                              ),
                              Text(_count.toString()),
                              GestureDetector(
                                child: Text('+'),
                                onTap: () => _count++,
                              )
                            ],
                          ),
                        ),
                        data[index]['addonCat'].length > 0
                            ? Container(
                                child: Text(
                                  'Customization available',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : Container(),
                      ],
                    )),
                Expanded(
                  flex: 10,
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
