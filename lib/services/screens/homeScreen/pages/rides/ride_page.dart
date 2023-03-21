
import 'dart:math' as math;

import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ridebud/services/appwrite_services/ride_provider.dart';

class RidePage extends ConsumerStatefulWidget {
  final String uid;
  final double lat;
  final double long;
  const RidePage(
    this.uid, this.lat, this.long, {
    super.key,
  });

  @override
  ConsumerState<RidePage> createState() => _RidePageState();
}

class _RidePageState extends ConsumerState<RidePage> {
  double _distance(DocumentList document,int index) {
  double currentLatitude = widget.lat;
  double currentLongitude = widget.long;
  double documentLatitude = document.documents[index]
                                                    .data['lat'];
  double documentLongitude = document.documents[index]
                                                    .data['long'];

  double latitudeDifference = (currentLatitude - documentLatitude) * (math.pi / 180);
  double longitudeDifference = (currentLongitude - documentLongitude) * (math.pi / 180);
  double a = 
      math.sin(latitudeDifference / 2) * math.sin(latitudeDifference / 2) +
      math.cos(currentLatitude * (math.pi / 180)) * math.cos(documentLatitude * (math.pi / 180)) *
      math.sin(longitudeDifference / 2) * math.sin(longitudeDifference / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  double earthRadius = 6371; // radius of the earth in km
  return earthRadius * c;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1720),
      body: 
      FutureBuilder(
        future: ref.watch(rideAPIProvider).getRideData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final data = snapshot.data;
          
          return snapshot.hasData
              ? snapshot.data.documents.isEmpty? Center(child: Lottie.asset('assets/animations/empty_car.json'),): ListView.builder(
                  itemCount: data.documents.length,
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    double distanceInMeters = Geolocator.distanceBetween(data.documents[index]
                                                    .data['lat'], data.documents[index]
                                                    .data['long'], widget.lat, widget.long);
                    double kmBetweenTwo = distanceInMeters/1000;
                    
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(42, 225, 220, 236),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.locationCrosshairs,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.documents[index]
                                                    .data['departure']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 1,
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                data.documents[index]
                                                    .data['dTime']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    letterSpacing: 1,
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.locationDot,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.documents[index]
                                                    .data['destination']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 1,
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                data.documents[index]
                                                    .data['aTime']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    letterSpacing: 1,
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  data.documents[index].data['driverid']
                                              .toString() ==
                                          widget.uid
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                59, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              'you published this',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundColor:
                                        Color.fromARGB(63, 225, 220, 236),
                                    child: Icon(
                                      MdiIcons.steering,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.documents[index].data['drivername']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        'Age:${data.documents[index].data['age'].toString()}',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            letterSpacing: 1,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    '₹ ${data.documents[index].data['price'].toString()}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
