import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tetse/Model/access.dart';

class AccessController{
  List<AccessController> _logs = [];
  List<AccessController> get logs => _logs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addLog(Access acc) async {
    await _firestore.collection('logs').add(acc.toMap());
  }

}