import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class AdminSendTheNotificationToUser {
  //This is the user token
  //used to send notification to that user

  String tokenOfReceiver = '';

  //by this FirebaseMessage.instance.getToken give the token
  // of Curent Connected Device (Admin Side Mean Sender Device).
  get() async {
    String? a = await FirebaseMessaging.instance.getToken();
    tokenOfReceiver = a!;
    print(a);
  }

  String titleOfNotifications = 'First Message';
  String bodyOfNotifications = 'Hey Its Me Fahad!';

  // This is key of Server Key Side Storage to select location of Server ,
  // This Storage is Given by Firebase Cloud messages,
  //This is Globale storage for Every Users For Temporay cache,
  //where I think temporary cache the Notification From Sender and then
  //Recever is online then send this message to Reciever.
  var serverKey =
      "AAAAbEzbOJw:APA91bHACYhnovRna_K7pqGfYzv6V_MMUyVMI0xIxVBOD7n1RLzHcM8jq4Cnxm9t8GAxFMEPxobQTj8Qwd6CgQG1fSdibgitfyhGGT-kC-fHrrkkFoeB9Chc56diDkHGawlEBZxczfJ5";

//**
//This Method is for Make Notifation For Send On Reciever device ,
// Its (to) name field taking The Reciever Token id for fetch Reciver Device //*//
  creatingFCMPayload(
      {String titleOfNotification = "This is the title of Notification",
      String bodyOfNotification = "This is the body of notification"}) {
    titleOfNotifications = titleOfNotification;
    bodyOfNotifications = bodyOfNotification;
    return jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': bodyOfNotification,
          'title': titleOfNotification,
        },
        //this data will be utilized by the clint
        //and client can respond by using this data
        'data': <String, dynamic>{
          'name': 'waqas',
          'time': '10 am',
          'service': 'service',
          'status': 'alive',
          'id': 'wwwweedd'
        },
        'to':
            // tokenOfReceiver
            'dypNsFB5QeCnECKgEZ_T1C:APA91bFCW9Po-rvYihFNIt3hHfZBuIhP_5LHn-yVhuVKfVbTNnrkLc4cOyLtZHmqV9cfriYPZSkijJmWzGfDjrTUES1kp8OuwsGrhs9fEPl8DbcgK51_o75wZzCMb2T_2iNphDA7oCwH'
      },
    );
  }

//**
//this Method  use api  (header) of Api we give ServerKey for Auturize by this its
// and by body (field) uper Created Notification message send by this On Server by this Api*/
  Future<bool> sendNotification() async {
    try {
      var res = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
          body: creatingFCMPayload(
              bodyOfNotification: bodyOfNotifications,
              titleOfNotification: titleOfNotifications));
      print(res.body);
      print(res.statusCode);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
