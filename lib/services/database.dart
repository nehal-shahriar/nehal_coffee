import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nehalcoffee/models/brew.dart';
import 'package:nehalcoffee/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String suger, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'suger': suger, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          sugars: doc.data['suger'] ?? '0',
          strength: doc.data['strength'] ?? 0);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['suger'],
      strength: snapshot.data['strength'],
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
