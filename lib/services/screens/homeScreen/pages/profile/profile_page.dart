import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ridebud/services/appwrite_services/appwrite_services_controller.dart';

class Profilepage extends ConsumerStatefulWidget {
  final String name;
  final String email;
  final String gender;
  final String dob;
  final String profilePhotoUrl;
  final String phone;
  final String uid;
  const Profilepage(this.name, this.email, this.gender, this.dob,
      this.profilePhotoUrl, this.phone, this.uid,
      {super.key});

  @override
  ConsumerState<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends ConsumerState<Profilepage> {
  PageStorageKey profileKey = const PageStorageKey("profilePageKey");
  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController _profileController = ScrollController();
  void logout() {
    ref.watch(appwriteControllerProvider).logout(context);
  }

  @override
  void dispose() {
    super.dispose();
    _profileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1a1720),
        body: PageStorage(
          key: profileKey,
          bucket: bucket,
          child: SingleChildScrollView(
            controller: _profileController,
            key: profileKey,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(75, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(20, 255, 255, 255),
                              radius: 35,
                              child: widget.profilePhotoUrl.isEmpty
                                  ? widget.gender == 'Male'
                                      ? const Icon(
                                          Icons.male,
                                          size: 35,
                                          color: Color(0xff2e4d4a),
                                        )
                                      : widget.gender.isEmpty?const Icon(MdiIcons.incognito,size: 35,color: Color(0xff2e4d4a),): const Icon(
                                          Icons.female,
                                          size: 35,
                                          color: Color(0xff2e4d4a),
                                        )
                                  : Image.network(widget.profilePhotoUrl),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name.isEmpty?'Guest':widget.name,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.email.isEmpty?'Anonymous Session':widget.email,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300),
                                ),
                                widget.email.isEmpty? const SizedBox(
                                  height: 5,
                                ):const SizedBox.shrink(),
                                widget.email.isEmpty? Text(
                                  widget.uid,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300),
                                ):const SizedBox.shrink(),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(25, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.idCard,
                              color: Color(0xff2e4d4a),
                              size: 20,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'KYC',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Complete the KYC to Publish Ride',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(25, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.car,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Add Vehicles',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Add the list of vehicles',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(115, 158, 158, 158),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.bell,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Notifications',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Controll email, SMS & push notifications',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(115, 158, 158, 158),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.report,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Reports',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'View Status of Scam Reports',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(25, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.buildingColumns,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Bank Details',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Add account to receive fare/refunds',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(115, 158, 158, 158),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.wallet,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Wallet',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Add money to wallet for easier transaction',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(115, 158, 158, 158),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.clockRotateLeft,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Payments History',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Manage refunds and previous transactions',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(25, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.help,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Help',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Contact our customer care',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(115, 158, 158, 158),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.policy,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Terms & Conditions',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Review our Policies',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color.fromARGB(115, 158, 158, 158),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.bug,
                                  color: Color(0xff2e4d4a),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Report Bugs',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Help us to make RideBud better',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.forward,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(25, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'LogOut',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Click to signout of the app',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoActionSheet(
                                        actions: <Widget>[
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color(0xff2e4d4a)),
                                            child: CupertinoActionSheetAction(
                                              child: const Text(
                                                "Logout",
                                                style: TextStyle(
                                                    color: Colors.redAccent),
                                              ),
                                              onPressed: () {
                                                HapticFeedback.mediumImpact();
                                                logout();
                                              },
                                            ),
                                          ),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            HapticFeedback.mediumImpact();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
