import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_expance/model/user_model.dart';
import 'package:money_expance/utilies/constant.dart';

class FirebaseDatabase {
  final box = GetStorage();
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static String collection = 'User';

  setData(
      {String? name,
      String? email,
      String? photoUrl,
      String? password,
      String? type,
      String? uId}) {
    var docId = firebaseFirestore.collection(collection).doc();
    UserDetails userModel = UserDetails(
      name: name,
      email: email,
      password: password,
      id: docId.id,
      type: type,
      uid: uId,
      photoUrl: photoUrl,
    );

    docId.set(userModel.toJson());
    box.write(KeyConstant.userProfile, userModel.toJson());
  }
}
