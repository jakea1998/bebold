import 'package:be_bold/blocs/repos/base_user_repo.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo extends BaseUserRepo {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  @override
  Future<void> createUser({required UserModel user}) async{
    // TODO: implement createUser
    await fs.collection("Users").doc(user.userId).set(user.toJson());
  }
  
  @override
  Stream<UserModel> loadUser({required String uid}) {
    // TODO: implement loadUser
    return fs.collection("Users").doc(uid).snapshots().map((event) => UserModel.fromJson(event.data() ?? {}));
  }
}
