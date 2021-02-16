import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  final Firestore _firestore = Firestore.instance;
  String ref ='products';
  String refOwa = 'productsOwanto';
  String refAcc = 'productsAccessoires';
  String refBij = 'productsBijoux';
  String refPyj = 'productsPyjamas';
  String refSou = 'productsSous';
  String refSac = 'productsSac';
  String refMai = 'productsMaillots';
  String refChau = 'productsChaussures';


  void uploadProduct(Map<String, dynamic> data , String category) {
    var id = Uuid();
    var productId = id.v1();
    data["id"] = productId;
    _firestore.collection(ref+category).document(productId).setData(data);

  }

  Future<List<DocumentSnapshot>> getOwa()=>_firestore.collection(refOwa).getDocuments().then((snaps) {
    return snaps.documents;
  }); Future<List<DocumentSnapshot>> getAcc()=>_firestore.collection(refAcc).getDocuments().then((snaps) {
    return snaps.documents;
  }); Future<List<DocumentSnapshot>> getBij()=>_firestore.collection(refBij).getDocuments().then((snaps) {
    return snaps.documents;
  }); Future<List<DocumentSnapshot>> getPyj()=>_firestore.collection(refPyj).getDocuments().then((snaps) {
    return snaps.documents;
  }); Future<List<DocumentSnapshot>> getSou()=>_firestore.collection(refSou).getDocuments().then((snaps) {
    return snaps.documents;
  }); Future<List<DocumentSnapshot>> getSac()=>_firestore.collection(refSac).getDocuments().then((snaps) {
    return snaps.documents;
  }); Future<List<DocumentSnapshot>> getMai()=>_firestore.collection(refMai).getDocuments().then((snaps) {
    return snaps.documents;
  }); Future<List<DocumentSnapshot>> getChau()=>_firestore.collection(refChau).getDocuments().then((snaps) {
    return snaps.documents;
  });
}