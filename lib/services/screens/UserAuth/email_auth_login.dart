import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebud/services/appwrite_services/appwrite_services_controller.dart';

class EmailAuthLogin extends ConsumerStatefulWidget {
  const EmailAuthLogin({super.key});

  @override
  ConsumerState<EmailAuthLogin> createState() => _EmailAuthLoginScreenState();
}

class _EmailAuthLoginScreenState extends ConsumerState<EmailAuthLogin> {
  
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  TextEditingController _passwordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  String password = '';

  int index = 0;
  
  void login()async{
    ref.watch(appwriteControllerProvider).loginUser(context,  email, password, ref);
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
             setState(() {
               index==1?index=0:index==2?index=1:index==3?index=2:Navigator.pop(context);
             });
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: index == 0
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Riding together just got even better! Can I have your email so we can keep your account secure and make carpooling a breeze?",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 0.5, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      onEditingComplete: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            index = 1;
                          });
                        }
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  email.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(46, 158, 158, 158),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        index = 1;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.green,
                                  ))),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Protect your account with a strong password. Enter a combination of letters, numbers, and symbols for added security:",
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey1,
                        child: TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!RegExp(
                                    r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})')
                                .hasMatch(value!)) {
                              return 'atleast 8 characters, 1 capital letter, 1 number and 1 symbol';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          onEditingComplete: () {
                            if (_formKey1.currentState!.validate()) {
                             login();
                            }
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      password.isNotEmpty
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(46, 158, 158, 158),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        if (_formKey1.currentState!
                                            .validate()) {
                                          login();
                                        }
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.check_mark,
                                        color: Colors.green,
                                      ))),
                            )
                          : const SizedBox.shrink(),
                    ],
                  )
                
      ),
    );
  }
}
