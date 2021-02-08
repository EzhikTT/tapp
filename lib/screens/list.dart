import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
            child: Card(
              elevation: 6.0,
              margin: EdgeInsets.all(12.0),
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Кузнецкий Мост #303',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.supervisor_account,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.0),
                            child: Text(
                              '10 рабочих мест',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.0),
                            child: Text(
                              '12 декабря 2020 - 11 ноября 2021',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Доступ: Все сотрудники (22 чел)',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
