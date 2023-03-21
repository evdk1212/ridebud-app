import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebud/core/providers.dart';
import 'package:ridebud/models/ride_details_model.dart';
import 'package:ridebud/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../Common/constants.dart';
import '../../models/user_model.dart';
import 'package:appwrite/models.dart' as models;
import 'package:http/http.dart' as http;



final rideAPIProvider = Provider((ref) {
  return RideAPI(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
    
  );
});


class RideAPI  {
  final Databases _db;
   final Realtime _realtime;
  
  RideAPI({
    required Databases db,
   required Realtime realtime,
  })  : _realtime=realtime,
        _db = db;

  Future<void> saveRideData(BuildContext context, RideModel rideModel) async {
    try {
      String rideId=const Uuid().v1();
      await _db.createDocument(
        
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.ridesCollection,
        documentId:rideId.toString(),
        data: rideModel.toMap(),
      );
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Ride Published');
     
    } on AppwriteException catch (e) {
      print(e);
    } 
  }
    
  
  Future<models.DocumentList> getRideData()  {
    
      final response =  _db.listDocuments(
        
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.ridesCollection,

      );
      return response;
      
    
  }
  Future<models.DocumentList> getRideDataCurrentUser(String uid)  {
    final response =  _db.listDocuments(
        
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.ridesCollection,


      );
      return response;
      
    
  }

  

}