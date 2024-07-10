import 'package:cloud_firestore/cloud_firestore.dart';

String generateUniqueId() {
  return FirebaseFirestore.instance.collection('dummy').doc().id;
}
