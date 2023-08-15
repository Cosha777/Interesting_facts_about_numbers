import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:interesting_facts_about_numbers/domain/models/models.dart';
import 'package:interesting_facts_about_numbers/error/internet_exeption.dart';

abstract class RemoteDataService {
  Future<Info> getNumberInfo(String number);

  Future<Info> getRandomNumberInfo();
}

class RemoteDataSourceHTTP implements RemoteDataService {
  @override
  Future<Info> getNumberInfo(String number) =>
      _getNumber('http://numbersapi.com/$number?json');

  @override
  Future<Info> getRandomNumberInfo() =>
      _getNumber('http://numbersapi.com/random/math?json');

  Future<Info> _getNumber(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final result = jsonDecode(response.body);
      return Info.fromJson(result);
    } catch (e) {
      throw InternetException('Network problem');
    }
  }
}
