

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GameInfoRepository {

  static const String VICTORIES_DOC_NAME = "victories";
  static const String FIELD_COUNT = "count";
  static GameInfoRepository _victoryRepository; 

  DocumentSnapshot _documentCache;

  static GameInfoRepository getInstance(){
    if(_victoryRepository == null)
      _victoryRepository = GameInfoRepository();

    return _victoryRepository;
  }

  Stream getVictoryStream(){
    return Firestore.instance.collection(VICTORIES_DOC_NAME).snapshots();
  }

  int getVictoryCount(AsyncSnapshot<dynamic> snapshot){
    if(snapshot.hasData){
      _documentCache = _getDocument(snapshot.data);
      return _documentCache.data[FIELD_COUNT];
    }
    return -1;
  }

  DocumentSnapshot _getDocument(QuerySnapshot snapshot){
    return snapshot.documents[0];
  }

  void addVictory() async {
    Firestore.instance.runTransaction((transaction) async {
      DocumentReference referance = _documentCache.reference;
      DocumentSnapshot documentSnapshot = await transaction.get(referance);
      await transaction.update(documentSnapshot.reference, {
        FIELD_COUNT: documentSnapshot.data[FIELD_COUNT] + 1,
      });
    });
  }
}