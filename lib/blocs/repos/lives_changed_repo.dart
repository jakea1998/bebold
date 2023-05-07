import 'package:be_bold/blocs/repos/base_lives_changed_repo.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class LivesChangedRepo extends BaseLivesChangedRepo {
  final fs = FirebaseFirestore.instance;
  @override
  Future<void> addLifeChanged(
      {required UserModel user, required String uid}) async {
    // TODO: implement addLifeChanged
    user.userId = Uuid().v1();
    await fs
        .collection("LivesChanged")
        .doc(uid)
        .collection("PersonalLivesChanged")
        .doc(user.userId)
        .set(user.toJson());
  }

  @override
  Stream<List<UserModel>> loadLivesChanged({required String uid}) {
    // TODO: implement loadLivesChanged
    return fs
        .collection("LivesChanged")
        .doc(uid)
        .collection("PersonalLivesChanged").snapshots().map((event) => event.docs.map((e)=>UserModel.fromJson(e.data())).toList());
  }
}
