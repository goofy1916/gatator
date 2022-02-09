import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gatator/app/data/models/subject_model.dart';

class FirebaseService {
  final CollectionReference _cseSubjects =
      FirebaseFirestore.instance.collection("cse_subjects");

  getRequestForCollection({
    required CollectionReference collectionReference,
    Map? data,
  }) async {
    final response = await collectionReference.get();
    final docs = response.docs;
    return docs;
  }

  getRequestForDoc(
      {required CollectionReference collectionReference,
      required String docId}) {}

  Future<List<Subject>> getSubjects() async {
    List allSubjectsDocs = await getRequestForCollection(
      collectionReference: _cseSubjects,
    );
    List<Map> allSubjects = [];
    for (final doc in allSubjectsDocs) {
      List subTopics = [];
      List allSubTopicsDocs = await getRequestForCollection(
          collectionReference:
              _cseSubjects.doc(doc.id).collection('sub_topics'));
      for (final subTopicDoc in allSubTopicsDocs) {
        subTopics.add({"title": subTopicDoc['title']});
      }
      allSubjects.add({"title": doc['title'], "subTopics": subTopics});
    }
    return subjectFromJson(jsonEncode(allSubjects));
  }
}
