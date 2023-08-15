import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:interesting_facts_about_numbers/data/repositories/local_data_source.dart';
import 'package:interesting_facts_about_numbers/data/repositories/remote_data_source.dart';
import 'package:interesting_facts_about_numbers/domain/models/models.dart';
import 'package:interesting_facts_about_numbers/domain/use_cases.dart';

final modelProvider = StateNotifierProvider<UserNotifier, ListInfo>(
  (ref) => UserNotifier(
    const ListInfo(list: []),
    UseCases(RemoteDataSourceHTTP(), LocalDataSourceSharedPref()),
  ),
);

class UserNotifier extends StateNotifier<ListInfo> {
  UserNotifier(super.state, this._useCases) {
    initialData();
  }

  final UseCases _useCases;
  List<Info> list = [];
  String _inputNumber = '';

  setInputNumber(String value) {
    _inputNumber = value;
  }

  get getInputNumber => _inputNumber;

  Future<void> getFact(String number) async {
    Info info = await _useCases.getNumberInfo(number);
    updateList(info);
  }

  Future<void> getRandomFact() async {
    Info info = await _useCases.getRandomNumberInfo();
    updateList(info);
  }

  Future<void> initialData() async {
    list = await _useCases.getData();
    state = state.copyWith(list: list);
  }

  Future<void> clearData() async {
    list = await _useCases.clearData();
    state = state.copyWith(list: list);
  }

  void updateList(Info info) {
    list.insert(0, Info(text: info.text, number: info.number));
    _useCases.saveData(list);
    state = state.copyWith(list: list);
  }
}
