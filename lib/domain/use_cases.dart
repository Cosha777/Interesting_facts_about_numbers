
import 'package:interesting_facts_about_numbers/data/repositories/local_data_source.dart';
import 'package:interesting_facts_about_numbers/data/repositories/remote_data_source.dart';
import 'package:interesting_facts_about_numbers/domain/models/models.dart';

class UseCases {
  final RemoteDataService remoteDataService;
  final LocalDataService localDataService;

  UseCases(this.remoteDataService, this.localDataService);

  getNumberInfo(String number) {
    return remoteDataService.getNumberInfo(number);
  }

  getRandomNumberInfo() {
    return remoteDataService.getRandomNumberInfo();
  }

  saveData(List<Info> list) {
    return localDataService.writeToLocalSource(list);
  }

  getData() {
    return localDataService.getFromLocalSource();
  }

  clearData() {
    return localDataService.clearLocalSource();
  }


}
