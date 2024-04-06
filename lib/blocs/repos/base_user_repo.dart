import 'package:be_bold/models/user_model.dart';

abstract class BaseUserRepo {
  Future<void> createUser({required UserModel user});
  Stream<UserModel> loadUser({required String uid});
  Future<void> deleteUser({required UserModel user});
  Future<bool> handleAnonymousUser({required String uid});
}
