import 'dart:convert';

import 'package:interesting_facts_about_numbers/domain/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataService {
  Future<List<Info>> getFromLocalSource();

  Future<void> writeToLocalSource(List<Info> list);

  Future<void> clearLocalSource();
}

const listKey = 'LIST_KEY';

class LocalDataSourceSharedPref implements LocalDataService {
  @override
  Future<List<Info>> getFromLocalSource() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final listOfNumbers = prefs.getStringList(listKey);
    if (listOfNumbers != null) {
      return Future.value(listOfNumbers
          .map((list) => Info.fromJson(jsonDecode(list)))
          .toList());
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<List<String>> writeToLocalSource(List<Info> lists) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listOfNumbers =
        lists.map((list) => jsonEncode(list.toJson())).toList();
    prefs.setStringList(listKey, listOfNumbers);
    return Future.value(listOfNumbers);
  }

  @override
  Future<List<Info>> clearLocalSource() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(listKey);
    return [];
  }
}
