import 'package:firebase_messaging/firebase_messaging.dart';

//  This Push Notification Class is behave for Receve Message From Server
class PushNotifications {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  initilizedFirebaseMessiging() async {
    await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        criticalAlert: true,
        sound: true);
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title.toString);
      print(event.notification!.body);
    });
  }
}
