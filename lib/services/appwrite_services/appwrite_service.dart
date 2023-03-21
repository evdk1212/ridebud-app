import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebud/Common/constants.dart';
import 'package:ridebud/core/providers.dart';
import 'package:ridebud/models/user_model.dart';
import 'package:ridebud/services/appwrite_services/appwrite_services_controller.dart';
import 'package:ridebud/services/appwrite_services/user_provider.dart';
import 'package:ridebud/services/screens/homeScreen/home_screen.dart';
import 'package:ridebud/services/screens/UserAuth/intro_screen.dart';
import 'package:ridebud/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

Client client = Client();

// Users users = Users(client);
// Account account = Account(client);

final appWriteServicesProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AppWriteService(account: account);
});
// final appWriteServicesProvider = Provider((ref) => AppWriteService());
final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(appWriteServicesProvider);
  return authController.getCurrentUser();
});

class AppWriteService {
  final Account _account;
  AppWriteService({required Account account}) : _account = account;

  Future<models.Account?> createUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String dob,
      required String gender,
      required WidgetRef ref}) async {
    final userID = const Uuid().v4();
    try {
      UserModel userModel = UserModel(
        name: name,
        email: email.toString(),
        password: password.toString(),
        uid: userID,
        dob: dob.toString(),
        gender: gender.toString(),
        phone: '',
        profilePhotoUrl: '',
      );
      final user = await _account.create(
          userId: userModel.uid,
          email: userModel.email.toString(),
          password: userModel.password.toString(),
          name: userModel.name.toString());
      final userdata = await ref.watch(userAPIProvider).saveUserData(userModel);
      
      final models.Session response = await _account.createEmailSession(
        email: email,
        password: password,
      );
      await _account.createVerification(url: 'http://localhost:5500/verify-email.html');
      
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Account Created Successfully');

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(response.userId)),
          (route) => false);
    } catch (e) {
      if (e is AppwriteException && e.code == 401) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, "Incorrect Password");

        // Redirect the user to the login page or show an error message
        // ...
      } else {
        // Handle other exceptions
        if (e.toString() == 'AppwriteException: null, Connection refused (0)') {
          showSnackBar(context, "Connection Refused");
        }
        if (e is AppwriteException && e.code == 409) {
          showSnackBar(context, "User Already Exist");
        } else {
          showSnackBar(context, e.toString());
        }
      }
    }
    return null;
    // ignore: use_build_context_synchronously
  }

  Future<models.Account?> getCurrentUser() async {
    try {
     return await _account.get();
     
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<models.Session?> loginUser(
      {required BuildContext context,
      required String email,
      required String password,
      required WidgetRef ref}) async {
    try {
      final models.Session response =
          await _account.createEmailSession(email: email, password: password);
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Logged In Successfully');
       
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(response.userId)),
          (route) => false);
    } catch (e) {
      if (e is AppwriteException && e.code == 401) {
        showSnackBar(context, "Incorrect Password");

        // Redirect the user to the login page or show an error message
        // ...
      } else {
        // Handle other exceptions
        if (e.toString() == 'AppwriteException: null, Connection refused (0)') {
          showSnackBar(context, "Connection Refused");
        }
        if (e is AppwriteException && e.code == 409) {
          showSnackBar(context, "User Already Exist");
        } else {
          showSnackBar(context, e.toString());
        }
      }
    }
    return null;
    // ignore: use_build_context_synchronously
  }

  logout(BuildContext context) async {
    final SharedPreferences prefs = await AppwriteConstants.prefs;
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('uid');

    _account.deleteSessions();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
        (route) => false);
  }

  Future<void> oAuthLogin(
      BuildContext context, String provider, WidgetRef ref) async {
    try{
      await _account
        .createOAuth2Session(provider: provider)
        .whenComplete(() async {
      final user = await _account.get();
    
      UserModel userModel = UserModel(
          email: user.email,
          name: user.name,
          uid: user.$id,
          password: 'password',
          dob: '',
          gender: 'gender',
          phone: 'phone',
          profilePhotoUrl: '');
      await ref.watch(userAPIProvider).saveUserData(userModel);
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Logged In Successfully');
       // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  HomeScreen(user.$id)),
        (route) => false);

    });
    
    
   
    }
    on AppwriteException catch(e){
      print(e);
    }
  }
  Future<void> guestLogin(BuildContext context, WidgetRef ref)async{
    try{
     await _account.createAnonymousSession();
     final user=await _account.get();
     UserModel userModel = UserModel(email: '', name: '', uid: user.$id, password: '', dob: '', gender: '', phone: '', profilePhotoUrl: '');
     await ref.watch(userAPIProvider).saveUserData(userModel);
     // ignore: use_build_context_synchronously
      showSnackBar(context, 'Logged In Successfully');
       // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  HomeScreen(user.$id)),
        (route) => false);
    }on AppwriteException catch(e){
      print(e);
    }
  }

  
}
