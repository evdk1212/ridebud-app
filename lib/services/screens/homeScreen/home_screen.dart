import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ridebud/services/appwrite_services/ride_provider.dart';

import 'package:ridebud/services/appwrite_services/user_provider.dart';

import 'package:ridebud/services/screens/homeScreen/pages/notification/notification_page.dart';
import 'package:ridebud/services/screens/homeScreen/pages/profile/profile_page.dart';
import 'package:ridebud/services/screens/homeScreen/pages/publish/publish_page.dart';
import 'package:ridebud/services/screens/homeScreen/pages/rides/ride_page.dart';
import 'package:ridebud/utils.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String? uid;

  const HomeScreen(this.uid, {super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = false;
  int index = 0;
  double lat = 0;
  double long = 0;

  model.Document? userdata;
  // model.DocumentList? ridedata;
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    userdata =
        await ref.read(userAPIProvider).getUserData(widget.uid.toString());
    // ridedata=await ref.read(rideAPIProvider).getRideData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getLperm() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context, 'Location Permission is needed to access this tab');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> getCurrentLocation() async {
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = currentPosition.latitude;
    long = currentPosition.longitude;
  }

  @override
  void initState() {
    super.initState();

    getData();
    getLperm();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final pageOptions = [
      RidePage(
        userdata?.data['uid'] ?? '',
        lat,
        long,
      ),
      PublishPage(
        userdata?.data['name'] ?? '',
        userdata?.data['uid'] ?? '',
        userdata?.data['phone'] ?? '',
      ),
      const NotificationPage(),
      Profilepage(
        userdata?.data['name'] ?? '',
        userdata?.data['email'] ?? '',
        userdata?.data['gender'] ?? '',
        userdata?.data['dob'] ?? '',
        userdata?.data['profilePhotoUrl'] ?? '',
        userdata?.data['phone'] ?? '',
        userdata?.data['uid'] ?? '',
      )
    ];
    return isLoading == false
        ? Scaffold(
            backgroundColor: const Color(0xff1a1720),
            body: pageOptions[index],
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color(0xff1a1720),
                enableFeedback: true,
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                onTap: (val) {
                  HapticFeedback.mediumImpact();
                  setState(() {
                    index = val;
                  });
                },
                unselectedItemColor: Colors.grey,
                selectedItemColor: const Color(0xff2e4d4a),
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(index == 0
                          ? CupertinoIcons.car_fill
                          : CupertinoIcons.car),
                      label: 'Ride'),
                  const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.add), label: 'Publish'),
                  BottomNavigationBarItem(
                      icon: Icon(index == 2
                          ? CupertinoIcons.bell_fill
                          : CupertinoIcons.bell),
                      label: 'Notifications'),
                  BottomNavigationBarItem(
                      icon: Icon(index == 3
                          ? CupertinoIcons.person_fill
                          : CupertinoIcons.person),
                      label: 'Profile'),
                ]),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
