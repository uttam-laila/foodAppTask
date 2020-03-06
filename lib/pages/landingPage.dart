import 'package:flutter/material.dart';
import 'package:foodapptask/consts/exports.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

FetchData _fetchData = FetchData();
List<Map<String, dynamic>> response;
var _snapshot;

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    _fetchData.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Choice> choices = <Choice>[];

    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: responseBloc.valueStream,
        builder: (context, snapshot) {
          _snapshot = snapshot;
          if (snapshot.data != null) {
            for (var i = 0;
                i < snapshot.data[0]['table_menu_list'].length;
                i++) {
              choices.add(Choice(
                  title: snapshot.data[0]['table_menu_list'][i]
                      ['menu_category'],
                  index: i));
            }
          }

          return snapshot.data == null
              ? Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()))
              : DefaultTabController(
                  length: choices.length,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      // centerTitle: true,
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back), onPressed: null),
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
                            Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.shopping_cart,
                                      color: Colors.black),
                                ),
                                Positioned(
                                  left: 16,
                                  top: 3.0,
                                    child: Stack(
                                  children: <Widget>[
                                    Icon(Icons.brightness_1,
                                        size: 18.0, color: Colors.red[800]),
                                    Positioned(
                                        top: 4.0,
                                        right: 6.0,
                                        child: Center(
                                          child: StreamBuilder<int>(
                                            initialData: 0,
                                            stream: cartCountBloc.valueStream,
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.w500),
                                              );
                                            }
                                          ),
                                        )),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      ],
                      title: (Text(
                        snapshot.data[0]['restaurant_name'],
                        style: TextStyle(color: Colors.black),
                      )),
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
        });
  }
}

class ChoiceCard extends StatefulWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  _ChoiceCardState createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  @override
  void initState() {
    response = _snapshot.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _cartCount = 0;
    return ListView.builder(
        itemCount: response[0]['table_menu_list'][widget.choice.index]
                ['category_dishes']
            .length,
        itemBuilder: (BuildContext context, int index) {
          final TextStyle heading1 =
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
          final TextStyle heading2 =
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
          var data = response[0]['table_menu_list'][widget.choice.index]
              ['category_dishes'];
          int _count = 0;
          IncrementItem _incrementBloc = IncrementItem();
          final TextStyle textStyle =
              TextStyle(color: Colors.white, fontSize: 24);
          return Card(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(
                          'assets/icons/nvicon.png',
                          color: data[index]['dish_Type'] == 2
                              ? Colors.green
                              : Colors.red,
                        ),
                      )),
                  Expanded(
                      flex: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    flex: 10,
                                    child: Text(
                                      data[index]['dish_name'],
                                      style: heading1,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '${data[index]['dish_currency']} ${data[index]['dish_price']}',
                                    style: heading2,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${data[index]['dish_calories']} Calories',
                                    style: heading2,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 8.0, bottom: 8.0, top: 8.0),
                              child: Text('${data[index]['dish_description']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 25,
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                    color: Colors
                                        .green, //Color.fromRGBO(255, 0, 0, 0.0),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Text(
                                        '-',
                                        style: textStyle,
                                      ),
                                      onTap: () {
                                        if (_count > 0) {
                                          --_count;
                                        }
                                        if (_cartCount>0) {
                                          --_cartCount;
                                        }
                                        _incrementBloc.valueStreamSink
                                            .add(_count);
                                        cartCountBloc.valueStreamSink.add(_cartCount);
                                      },
                                    ),
                                    StreamBuilder<int>(
                                        initialData: 0,
                                        stream: _incrementBloc.valueStream,
                                        builder: (context, snapshot) {
                                          return Text(snapshot.data.toString(),
                                              style: TextStyle(
                                                  color: Colors.white));
                                        }),
                                    GestureDetector(
                                      child: Text('+', style: textStyle),
                                      onTap: () {
                                        ++_count;
                                        ++_cartCount;
                                        _incrementBloc.valueStreamSink
                                            .add(_count);
                                        cartCountBloc.valueStreamSink.add(_cartCount);
                                      },
                                    )
                                  ],
                                ),
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
                        ),
                      )),
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Image.network(
                        data[index]['dish_image'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
