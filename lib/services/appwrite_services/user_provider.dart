import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebud/core/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/constants.dart';
import '../../models/user_model.dart';
import 'package:appwrite/models.dart' as models;

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
    
  );
});


class UserAPI  {
  final Databases _db;
   final Realtime _realtime;
  
  UserAPI({
    required Databases db,
   required Realtime realtime,
  })  : _realtime=realtime,
        _db = db;

  Future<void> saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: userModel.uid.toString(),
        data: userModel.toMap(),
      );
     
    } on AppwriteException catch (e) {
      print(e);
    } 
  }
    
  
  Future<models.Document> getUserData(String uid) async {
    try {
      final response = await _db.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: uid
      );
      return response;
    } on AppwriteException {
      rethrow;
    }
  }
  Stream<RealtimeMessage> getLatestUserProfileData() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.usersCollection}.documents'
    ]).stream;
  }

}