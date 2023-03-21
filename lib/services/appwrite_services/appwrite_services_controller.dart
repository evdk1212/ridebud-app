import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebud/services/appwrite_services/appwrite_service.dart';
import 'package:appwrite/models.dart' as models;

final appwriteControllerProvider = Provider((ref)=>AppWriteController(appWriteService: ref.read(appWriteServicesProvider)));

class AppWriteController{
  final AppWriteService _appWriteService;
  AppWriteController({required AppWriteService appWriteService}): _appWriteService=appWriteService;

  
  Future<models.Account?> createUser(BuildContext context, String name,String email, String password,String dob,String gender,WidgetRef ref)async{
    
  return await _appWriteService.createUser(context: context, name: name, email: email, password: password, gender: gender,dob:dob,ref: ref );
  }
  Future<models.Session?> loginUser(BuildContext context,String email, String password,WidgetRef ref)async{
    
  return await _appWriteService.loginUser(context: context,  email: email, password: password, ref: ref);
  }
  
  void logout(BuildContext context){
    _appWriteService.logout(context);
  }

  Future<models.Account?> getCurrentUser()async{
   return await _appWriteService.getCurrentUser();
    
  }
  Future<void> oAuthLogin(BuildContext context, String provider,WidgetRef ref)async{
    await _appWriteService.oAuthLogin(context, provider,ref);
  }
  Future<void> guestLogin(BuildContext context,WidgetRef ref)async{
    await _appWriteService.guestLogin(context,ref);
  }
 
}