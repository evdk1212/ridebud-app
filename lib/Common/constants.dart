import 'package:shared_preferences/shared_preferences.dart';

class AppwriteConstants {
  // static const String databaseId = '63de0111204e6b498b12';
  // static const String projectId = '63d78a250da9df937213';
  // static const String endPoint = 'http://localhost/v1';
  static const String databaseId = '63de111e1985171f4453';
  static const String projectId = '63d9e35334f7cc0ccf3c';
  static const String endPoint = 'http://172-105-39-119.ip.linodeusercontent.com/v1';

  // static const String usersCollection = '63de011aeb466ce8d258';
  static const String usersCollection = '63de113039a2691daa73';
  static const String ridesCollection = '63e3a175c58e47dad0ad';
  // static const String tweetsCollection = '63cbd6781a8ce89dcb95';
  // static const String notificationsCollection = '63cd5ff88b08e40a11bc';

  // static const String imagesBucket = '63cbdab48cdbccb6b34e';
static final Future<SharedPreferences> prefs =
      SharedPreferences.getInstance();
  // static String imageUrl(String imageId) =>
  //     '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}


//  client
//         .setEndpoint('http://172.105.39.119/v1')
//         .setProject('63d9e35334f7cc0ccf3c')
//         .setSelfSigned(status: true);