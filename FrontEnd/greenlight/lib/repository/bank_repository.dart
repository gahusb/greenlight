import 'package:greenlight/model/bank.dart';

abstract class BankRepository {
  Future<List<Bank>> getBanks();

  Future addBank(int id,
      String title,
      String tel,
      String zipcode,
      String address,
      double lat,
      double lng,
      String imagePath,
      String organName,
      int organVolumn);

  Future updateBank(
      int id,
      String title,
      String tel,
      String zipcode,
      String address,
      double lat,
      double lng,
      String imagePath,
      String organName,
      int organVolumn);

  Future removeBank(String content);
}