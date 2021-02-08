import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tapp/models/booking.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  List<dynamic> _focusedEvents = [];
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();

    final _now = DateTime.utc(2021, 2, 8, 0, 0, 0, 0, 0);

    _events = {
      _now.add(Duration(days: 3)): [
        '#01',
        '#02',
        '#03',
        '#04',
        '#05',
        '#06',
        '#07',
        '#08',
        '#09',
        '#10',
      ],
      _now.add(Duration(days: 4)): [
        '#01',
        '#02',
        '#03',
        '#04',
        '#05',
        '#06',
        '#07',
        '#08',
        '#09',
        '#10',
      ],
      _now.add(Duration(days: 5)): [
        '#01',
        '#02',
        '#03',
        '#04',
        '#05',
        '#06',
        '#07',
        '#08',
        '#09',
        '#10',
      ],
    };

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  int getEventsCount() => _calendarController?.visibleEvents[_calendarController?.focusedDay]?.length ?? 0;

  void bookingPlace() {
    Navigator.pushNamed(
      context,
      '/booking',
      arguments: ({
        'events': _focusedEvents,
        'date': _calendarController.focusedDay,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var store = context.watch<BookingModel>();
    // var items = store.items.where((i) => i.date == _calendarController.focusedDay).map((i) => i.place).toList();
    var newList = _events;

    for (var i = 0; i < newList.keys.length; i++) {
      var day = newList.keys.elementAt(i);
      var items = store.items
          .where((it) => day.difference(it.date).inDays == 0)
          .map((it) => it.place as String)
          .toList(growable: true);
      if (newList[day] != null && newList[day].length > 0 && items.length > 0) {
        var places = (newList[day] as List).where((it) => (items as List).indexOf(it as String) == -1);

        // var res = newList[day].where((it) => items.indexOf(it) == -1);
        newList[day] = places.toList();
      }
    }
    setState(() {
      _events = newList;
    });

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
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: TableCalendar(
              onDaySelected: (DateTime date, List<dynamic> events, List<dynamic> holidays) {
                setState(() {
                  _focusedEvents = events;
                });
              },
              calendarController: _calendarController,
              startingDayOfWeek: StartingDayOfWeek.monday,
              events: _events,
              calendarStyle: CalendarStyle(
                markersAlignment: Alignment.topRight,
                weekdayStyle: TextStyle(fontSize: 16.0),
              ),
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, _) => Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                markersBuilder: (context, date, events, holidays) => <Widget>[
                  Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
                    child: Text(
                      '${events.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            elevation: 0,
            onPressed: _focusedEvents.length == 0 ? null : () => bookingPlace(),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minWidth: double.infinity),
              padding: EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: _focusedEvents.length == 0 ? Colors.black54 : Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(56.0)),
              ),
              child: Text(
                'Выбрать место(Доступно ${_focusedEvents.length})',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
