import 'package:flutter/cupertino.dart';

class BookingModel extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => _items;

  List<Item> bookingForDate(DateTime date) => _items.where((i) => i.date.difference(date).inDays == 0);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}

class Item {
  DateTime date;
  String place;
  String user;

  Item(this.date, this.place, this.user);
}
