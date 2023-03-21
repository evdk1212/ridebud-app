import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ridebud/services/appwrite_services/appwrite_services_controller.dart';
import 'package:ridebud/services/screens/UserAuth/email_auth_screen.dart';
import 'package:ridebud/services/screens/UserAuth/login_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  void oAuthLogin(String provider)async{
    ref.watch(appwriteControllerProvider).oAuthLogin(context,provider,ref);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1720),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To authenticate, which do you prefer: sending a love letter via email, getting cozy with Google, or be our guest?',
              style: TextStyle(color: Colors.white, letterSpacing: 1),
            ),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const EmailAuthScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff2e4d4a),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(10),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const  [
                        Icon(CupertinoIcons.mail,color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          'Continue with Email',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, letterSpacing: 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                oAuthLogin('google');
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 61, 198, 222),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const  [
                        Icon(FontAwesomeIcons.google,color: Colors.white,size: 20,),
                        SizedBox(width: 6,),
                        Text(
                          'Continue with Google',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, letterSpacing: 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:const Color.fromARGB(255, 254, 254, 254),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const  [
                        Icon(Icons.person),
                        SizedBox(width: 5,),
                        Text(
                          'Guest Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, letterSpacing: 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Already a Rider?', style: TextStyle(color: Colors.white,fontSize: 20,),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                  }, child: const Text('Login',style: TextStyle(color:  Color(0xff2e4d4a)),)),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Text('By signing up, you agree to our terms and conditions and can rest assured that your personal information is safe with us. At Ridebud, we take the privacy and security of our users seriously, and we have implemented robust measures to ensure that your information is protected at all times. So, sit back, relax and let us handle the details.',style: TextStyle(color: Colors.grey,letterSpacing: 1),),
            const Spacer(),
            const Center(child:  Text('Copyrights@Aebora',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),))
          ],
        ),
      ),
    );
  }
}
