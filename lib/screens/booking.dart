import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/booking.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _value = '';
  int _currentTab = 0;

  void _addBooking(BuildContext context, Item item) {
    var booking = context.read<BookingModel>();
    booking.add(item);
    Navigator.pushNamed(context, '/calendar');
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> _args = ModalRoute.of(context).settings.arguments;
    DateTime _date = _args['date'] as DateTime;
    var _places = (_args['events'] as List).map((i) => i as String) ?? [];
    _date = DateTime(_date.year, _date.month, _date.day, 0, 0, 0, 0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Бронирование места в офисе'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: '')
        ],
        currentIndex: _currentTab,
        onTap: (int index) => setState(() {
          _currentTab = index;
        }),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Кузнецкий мост #303'),
              ],
            ),
            Text('Выберите день или промежуток для брони рабочего места в офисе (условия от заказчика)'),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            Card(
              elevation: 8.0,
              margin: EdgeInsets.only(top: 24.0),
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Выбрать дату *', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 8.0),
                          child: Text(_date.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //   ),
              // ],
            ),
            Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Выберете рабочее место', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 8.0),
                          child: DropdownButton<String>(
                            value: _value == '' ? _places.first : _value,
                            // elevation: 12,
                            // isExpanded: true,
                            onChanged: (String newValue) => setState(() {
                              _value = newValue;
                            }),
                            items: _places.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              },
                            ).toList(),
                            hint: Text('Выбрать рабочее место *'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //   ),
              // ],
            ),
            RaisedButton(
              color: Colors.transparent,
              disabledColor: Colors.transparent,
              onPressed: _value == '' ? null : () => _addBooking(context, Item(_date, _value, 'Test user')),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minWidth: double.infinity),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: _value == '' ? Colors.black54 : Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(56.0)),
                ),
                child: Text(
                  'Забронировать',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
