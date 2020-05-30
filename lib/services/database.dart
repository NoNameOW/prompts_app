

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prompt_app/models/prompt.dart';

class DataBaseService {
  final String uid;
  DataBaseService({this.uid});

  final CollectionReference allPrompts = Firestore.instance.collection('all_prompts');

  Future newPrompt(String text, String title) async {
    try{
    await allPrompts.document(title).setData(
      {
        'title' : title,
        'text' : text,
        'timestamp': DateTime.now()
      }
      
    );
    return 'yes';
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  Future addResponse(String title, String uid, String response) async{
    try{
    DocumentReference doc = allPrompts.document(title);
    await doc.updateData({
      uid: response
    }
    
      
    );
    return 'yes';
    } catch(e){
      print(e.toString());
      return null;
    }    
  }

  Future getRelevantData(String uid) async {
    QuerySnapshot doclist = await allPrompts.getDocuments();
    var docs =  doclist.documents;
    if (docs.isNotEmpty){
      
      
      
      print(docs);
      QuerySnapshot doclist = await allPrompts.orderBy('timestamp').getDocuments();
      docs =  doclist.documents;
      var doc = docs.last;
      print(docs[0]['title']);
      print(docs.last['title']);
      
      var  reldata = {'text' : doc['text'], 'response' : doc[uid], 'title' : doc['title'] };
      print(reldata['title']);
      return reldata;
    } else {
      return null;
    }
  }

  Stream<QuerySnapshot> get prompts {
    return allPrompts.snapshots();
  }


}