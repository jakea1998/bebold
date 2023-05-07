import 'package:be_bold/models/user_model.dart';

abstract class BaseLivesChangedRepo {
  Future<void> addLifeChanged({required UserModel user,required String uid});
  Stream<List<UserModel>> loadLivesChanged({required String uid});
}