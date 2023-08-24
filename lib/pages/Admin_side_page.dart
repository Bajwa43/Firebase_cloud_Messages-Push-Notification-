import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  var apptCollection = FirebaseFirestore.instance.collection('Appointments');

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      apptCollection.doc('Token').set({'admin-token': token});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin-Page'),
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
