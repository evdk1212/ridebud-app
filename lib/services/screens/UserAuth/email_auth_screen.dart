import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebud/services/appwrite_services/appwrite_services_controller.dart';

class EmailAuthScreen extends ConsumerStatefulWidget {
  const EmailAuthScreen({super.key});

  @override
  ConsumerState<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends ConsumerState<EmailAuthScreen> {
  
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  TextEditingController _nameController = TextEditingController();
  final _nameKey = GlobalKey<FormState>();
  String name = '';
  TextEditingController _passwordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  String password = '';
  TextEditingController _dobController = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();
  String dob = '';
  DateTime? _dob;
  TextEditingController _genderController = TextEditingController();
  final _formKey3 = GlobalKey<FormState>();
  String gender = '';

  int index = 0;
  
  void signUp()async{
    ref.watch(appwriteControllerProvider).createUser(context, name, email, password, dob, gender, ref);
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
            ?  Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Name?",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 0.5, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      onEditingComplete: () {
                       
                          setState(() {
                            index = 1;
                          });
                        
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  name.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(46, 158, 158, 158),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                   setState(() {
                                     index=1;
                                   });
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.green,
                                  ))),
                        )
                      : const SizedBox.shrink(),
                ],
              ):index==1? Column(
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
                            index = 2;
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
                                        index = 2;
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
            : index == 2
                ? Column(
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
                              setState(() {
                                index = 3;
                              });
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
                                          setState(() {
                                            index = 3;
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
                :index==3? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Let's celebrate your birthday every year! What's the date you came into this world?",
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey2,
                        child: InkWell(
                          onTap: () {},
                          child: TextFormField(
                            controller: _dobController,
                            style: const TextStyle(color: Colors.white),
                            
                            onEditingComplete: () {
                              
                                setState(() {
                                  index = 3;
                                });
                             
                            },
                            autofocus: true,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: dob.isEmpty ? 'Please Select DOB' : dob,
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                     
                      dob.isNotEmpty
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
                                        setState(() {
                                          index=4;
                                        });
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.check_mark,
                                        color: Colors.green,
                                      ))),
                            )
                          : const SizedBox.shrink(),
                          const SizedBox(height: 20,),
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        
                        child: CupertinoTheme(
                          data: const CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime date) {
                              setState(() {
                                dob = date.toString();
                              });
                            },
                            minimumDate: DateTime(1900),
                            maximumDate: DateTime.now(),
                            initialDateTime: _dob ?? DateTime(2000),
                            maximumYear: DateTime.now().year,
                          ),
                        ),
                      ),
                      
                    ],
                  ): Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Gender?",
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey3,
                        child: InkWell(
                          onTap: () {},
                          child: TextFormField(
                            controller: _genderController,
                            style: const TextStyle(color: Colors.white),
                            readOnly: true,
                            onChanged: (val){
                              setState(() {
                                gender=val;
                              });
                            },
                            onEditingComplete: () {
                              
                                
                             
                            },
                            autofocus: true,
                           
                            decoration: InputDecoration(
                              hintText: gender.isEmpty?'Gender':gender,
                              
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                     
                      gender.isNotEmpty
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
                                       signUp();
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.check_mark,
                                        color: Colors.green,
                                      ))),
                            )
                          : const SizedBox.shrink(),
                          const SizedBox(height: 20,),
                          SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        
                        child: CupertinoTheme(
                          data: const CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ),
                          child: CupertinoPicker(itemExtent: 50, onSelectedItemChanged: (val){
            
                            setState(() {
                              val==0?gender='Male':val==1?gender='Female':gender= 'Prefer Not To Say';
                            });
                          }, children: [
                             Padding(
                               padding: const EdgeInsets.only(top:10.0),
                               child: Container(
                                height: MediaQuery.of(context).size.height/2,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(child: Text('Male',style: TextStyle(color: Colors.white),))),
                             ),
                           Padding(
                             padding: const EdgeInsets.only(top:10.0),
                             child: Container(
                                height: MediaQuery.of(context).size.height/2,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(child: Text('Female',style: TextStyle(color: Colors.white),))),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top:10.0),
                             child: Container(
                                height: MediaQuery.of(context).size.height/2,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(child: Text('Prefer Not To Say',style: TextStyle(color: Colors.white),))),
                           ),
                          ]),
                        ),
                      ),
                      
                    ],
                  ),
      ),
    );
  }
}
