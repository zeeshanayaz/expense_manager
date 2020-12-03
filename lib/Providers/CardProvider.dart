import 'dart:collection';
import 'dart:convert';

import 'package:expense_manager/Model/CardModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardProvider with ChangeNotifier {
  List<CardModel> cards = [];

  CardProvider() {
    initialState();
  }

  UnmodifiableListView<CardModel> get allCards => UnmodifiableListView(cards);

  void initialState() {
    syncDataWithProvider();
  }

  void addCard(CardModel _card) {
    cards.add(_card);

    updateSharedPreferences();

    notifyListeners();
  }

  void removeCard(CardModel _card) {
    cards.removeWhere((card) => card.number == _card.number);

    updateSharedPreferences();
    notifyListeners();
  }

  int getCardLength() {
    return cards.length;
  }

  Future updateSharedPreferences() async {
    List<String> myCards = cards.map((f) => json.encode(f.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('cards', myCards);
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('cards');

    if (result != null) {
      cards = result.map((e) => CardModel.fromJson(json.decode(e))).toList();
    }

    notifyListeners();
  }
}
