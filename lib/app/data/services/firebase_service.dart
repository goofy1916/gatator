import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:gatator/app/data/models/subject_model.dart';

class FirebaseService {
  final CollectionReference _cseSubjects =
      FirebaseFirestore.instance.collection("cse_subjects");
  final CollectionReference _questions =
      FirebaseFirestore.instance.collection("questions");

  getCollection({
    required CollectionReference collectionReference,
    Map? data,
  }) async {
    final response = await collectionReference.get();
    final docs = response.docs;
    return docs;
  }

  getDoc(
      {required CollectionReference collectionReference,
      required String docId}) {}

  putData(
      {required CollectionReference collectionReference,
      required String docId}) {}

  Future<List<Subject>> getSubjects() async {
    List allSubjectsDocs = await getCollection(
      collectionReference: _cseSubjects,
    );
    List<Subject> allSubjects = [];
    for (final doc in allSubjectsDocs) {
      allSubjects.add(Subject.fromJson(doc.data()));
    }
    return subjectFromJson(jsonEncode(allSubjects));
  }

  Future uploadImageToFirebase(
      imageFile, String problemTitle, bool isQuestion) async {
    problemTitle = isQuestion
        ? 'problems/questions/${problemTitle.toLowerCase()}'
        : 'problems/answers/${problemTitle.toLowerCase()}';
    fs.Reference firebaseStorageRef =
        fs.FirebaseStorage.instance.ref().child(problemTitle);
    try {
      fs.SettableMetadata metadata =
          fs.SettableMetadata(contentType: "image/jpg");
      fs.UploadTask uploadTask = (kIsWeb)
          ? firebaseStorageRef.putData(imageFile, metadata)
          : firebaseStorageRef.putFile(imageFile);
      fs.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      return taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      log("Upload failed: " + e.toString());
    }
  }

  getQuestionsForSelection(Subject subject, List<String> subtopics) async {
    String sub = subject.title;
    List<String> search = subtopics;
    final result = await _questions
        .where("topic", isEqualTo: sub)
        .where("subTopic", whereIn: search)
        .get();
    return result.docs;
  }

  Future postQuestion(Map<String, dynamic> json) async {
    await FirebaseFirestore.instance.collection("questions").doc().set(json);
    return true;
  }
}
