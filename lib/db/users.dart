import 'package:admincoinacc/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UsersService {
  Firestore _firestore = Firestore.instance;
  String ref = 'users';

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore
        .collection('categories')
        .document(categoryId)
        .setData({'category': name});
  }

  Future<List<DocumentSnapshot>> getUsers()=>_firestore.collection(ref).getDocuments().then((snaps) {
    return snaps.documents;
  });


  void createUser(Map data) {
    _firestore.collection(ref).document(data["uid"]).setData(data);
  }

  Future<UserModel> getUserById(String id)=> _firestore.collection(ref).document(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  // void addToCart({String userId, CartItemModel cartItem}){
  //   _firestore.collection(collection).document(userId).updateData({
  //     "cart": FieldValue.arrayUnion([cartItem.toMap()])
  //   });
  // }

  // void removeFromCart({String userId, CartItemModel cartItem}){
  //   _firestore.collection(collection).document(userId).updateData({
  //     "cart": FieldValue.arrayRemove([cartItem.toMap()])
  //   });
  // }


  Future<List<DocumentSnapshot>> getSuggestions(String suggestion)=>_firestore
      .collection(ref)
      .where('kullanici', isEqualTo: suggestion)
      .getDocuments()
      .then((snap) {
    return snap.documents;
  });

}
