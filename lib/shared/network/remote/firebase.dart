import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:http/http.dart' as http;
import 'package:masar/shared/network/local/cach_helper.dart';
//import 'package:googleapis_auth/auth_io.dart' as auth;
class MyFirebase {
  late var deviceToken;
  var accessToken;
 // final _firebaseMessaging = FirebaseMessaging.instance;

// initialize notifications for this app or device
  Future<void> initNotifications() async {
    // get device token
    // var messaging = await FirebaseMessaging.instance.getToken();
     deviceToken = await FirebaseMessaging.instance.getToken();
    //  DeviceToken = deviceToken;
    // print(
    //     "===================Device FirebaseMessaging Token====================");
    print(deviceToken);
    CachHelper.putString(key: "deviceToken", value: deviceToken);
    // print(
    //     "===================Device FirebaseMessaging Token====================");
  }

  // Future<String?> getAccessToken() async {
  //    final serviceAccountJson = {
  //       "type": "service_account",
  // "project_id": "masar-9f0b8",
  // "private_key_id": "9c9319bc562386670619cb539154908257ea03b0",
  // "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCsFj9JyhcJM2aC\n0CiJJzBYJqsM56G+qMim3JDoo6pWc8WEBsQhPEHp+272qvX2rloqjL2CyYqFIh8B\n6c5EC80N23PK5tR/HtjMAXHjeH5XCdx1J9yHuy7MAAhqzK9ROhbikP0tCS7KYCDa\nP1Oa05DYYNKQzBWyRhjlYAP9udSNeyTOUfARyJZZyK1uSLNaA4HbqaKo9G5Eg0JE\nLLxagwp1a1YG+1B8zdCeqHpLo8vMiF4o/lGe1v7BN265xCFMv9CWQzp41fS/7OHv\nBb2Na4TAXQwohRsWLIlBfzudEsFDQZLA0phfgr6Mk89X4ghwnpS43Xatx+kXGDbo\nxP+VEfx5AgMBAAECggEAA6UafNGAHKinLZLjYulOtbVG9vhihYdtbZRbKORLj7Z2\nyum6RoJwWniCBI1BNbMCc6eEvZQPgCuleLzHKsuNsbMR4Cy0uEcS3DpVG1ZyZZ1O\nuzgHjKPvNTC0fO+eMIQglzavOCCbSjvQQlMoTg2YYi7l0t2RwZOIxDX9C6cfnIoD\n171S25PMk8XPp/OL6becV9IRGkv046TzOl/eb/zEcGsSXYNINO5VUuPLqY67qVLl\nhkea4snjcrh8uBaB8WJWm89CdbLTnaGOVRVMGm4yPGHMxLizXwV2CQPUQQMhKFvA\n1Ca4B81UCTepFJ7nEBs+OFDLkrQz+d6dfokv53cJ4QKBgQDwZGvyB9K4XbqrDEeR\n4PWGfI3yHamgEdvS5EkP/PfVArw0+YPXfNKL6jz07r5uGObBlpyEkbeY5Jp1YI7b\nJJ4P2czMLajlxZpWjZzUXPCMo9Xwbm//WwuvzQ+8Wxk9Mc+LvyonivpuODtvvMe/\n/k60asUfxTebv2P2MgPdedwJ2QKBgQC3QoRM2emqs8JRRExahpUJVMBG32xtlqnD\njJf63PzBvEQok0KkOwMVFTggfQcTI4qWPvQb3WwS1DX8WsHGQeYj1d4v94jADaHI\ng3sWj6feQURjn87fbinOdo7v/dRS2lfILreZVHRtFz4PvuIvXRH3NWchiqpRhliN\nIPKdhnxDoQKBgDb5EAJiLZsBvC1feoJuqlcd5qwGgoLbcqSwldC1Lcule3q10KOX\npOJgJ55vdlbhFOwSUCq01AJ/zJ6o/SI6JndDfGT40BXzcU73xXR+6HeRA9yetLf1\njx+dykptnsDywh6YEcDHNGu+KkFsL1XFhyQVAo04YXYZd3eWinG8a0hJAoGAD+wJ\njpvIP3qKwYDLmXnj7QGeCwpSY1sZuNG4SqV0mGiBC31v5tDxvZ0wWTJDsRf/bHpf\nvyQHxcMGRbyk5VLIagik20oIaZdFnSQ/R4CHtzm4dWdnE+aAX13RoWxOTDyIL+5P\nKVU7IFdKnxeYk0Dk1LOhGDrx/U9M1kYsjh8nIMECgYEAwnLD74ydqKuxXQJKKA6M\naDzb/8C4BYc4/0/UzVA53Ye0I67x7wZ0Joh6lCFB8ORGR+J7+GCfIm5o0oqwWK2N\nOwVJ+VOXS+nPc5fxwfzwzA1aGLSWcx/pOtGVhoes6V7YIgFS1JqFJpDXDSNdkhsf\nHAzKL2jtoN64kQ68ff7qvJ4=\n-----END PRIVATE KEY-----\n",
  // "client_email": "firebase-adminsdk-fbsvc@masar-9f0b8.iam.gserviceaccount.com",
  // "client_id": "111879227050250268734",
  // "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  // "token_uri": "https://oauth2.googleapis.com/token",
  // "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  // "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40masar-9f0b8.iam.gserviceaccount.com",
  // "universe_domain": "googleapis.com"
  //   };
   
  //   List<String> scopes = [
  //     "https://www.googleapis.com/auth/userinfo.email",
  //     "https://www.googleapis.com/auth/firebase.database",
  //     "https://www.googleapis.com/auth/firebase.messaging"
  //   ];
  //   try {
  //     http.Client client = await auth.clientViaServiceAccount(
  //         auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
  //     auth.AccessCredentials credentials =
  //         await auth.obtainAccessCredentialsViaServiceAccount(
  //             auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
  //             scopes,
  //             client);
  //     client.close();
  //     print(
  //         "Access Token: ${credentials.accessToken.data}"); // Print Access Token
  //          accessToken=credentials.accessToken.data;
  //     return credentials.accessToken.data;
  //   } catch (e) {
  //     print("Error getting access token: $e");
  //     return null;
  //   }
  // }

////////////////////////////

// sendNoti()async{
//   var headersList = {
//  'Accept': '*/*',
//  'Content-Type': 'application/json',
//  'Authorization': 'Bearer $accessToken' 
// };
// var url = Uri.parse('https://fcm.googleapis.com/v1/projects/ecommerce-48a10/messages:send');
// var body = {
//   "message": {
//     "token": "/topics/khader",
//     "notification": {
//       "title": "Notification Title",
//       "body": "Notification Body"
//     },
//     "android": {
//       "notification": {
//         "notification_priority": "PRIORITY_MAX",
//         "sound": "default"
//       }
//     },
//     "apns": {
//       "payload": {
//         "aps": {
//           "content_available": true
//         }
//       }
//     },
//     "data": {
//       "type": "type",
//       "id": "userId",
//       "click_action": "FLUTTER_NOTIFICATION_CLICK"
//     }
//   }
// };
// var req = http.Request('POST', url);
// req.headers.addAll(headersList);
// req.body = json.encode(body);
// var res = await req.send();
// final resBody = await res.stream.bytesToString();
// if (res.statusCode >= 200 && res.statusCode < 300) {
//   print(resBody);
// }
// else {
//   print(res.reasonPhrase);
// }
// }

myrequestPermission()async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  print('User granted permission');
} else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  print('User granted provisional permission');
} else {
  print('User declined or has not accepted permission');
}
}




  Future init() async {
    
     
    await initNotifications();
// myrequestPermission();
  //  await getAccessToken();
  //  await sendNoti();
  
  
    
   
  }
}

 Future<void> initFirebase() async {
  MyFirebase fire=MyFirebase();
  await fire.init();
  
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print("==========Frontgrount");
  //     if (message.notification!.title != null) {
  //       print("==========${message.notification!.title}");
  //     }
  //   });
}