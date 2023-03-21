import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:ridebud/models/ride_details_model.dart';
import 'package:ridebud/services/appwrite_services/ride_provider.dart';
import 'package:ridebud/services/screens/homeScreen/home_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ridebud/services/screens/homeScreen/pages/publish/my_rides.dart';
import 'package:ridebud/utils.dart';


class PublishPage extends ConsumerStatefulWidget {
  final String drivername;
  final String driverid;
  final String phone;

  const PublishPage(this.drivername, this.driverid, this.phone, {super.key});

  @override
  ConsumerState<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends ConsumerState<PublishPage> {
  TextEditingController destinationController = TextEditingController();
  TextEditingController departureController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dtimeController = TextEditingController();
  TextEditingController atimeController = TextEditingController();
  final _departKey = GlobalKey<FormState>();
  final _arrivalKey = GlobalKey<FormState>();
  final _dateKey = GlobalKey<FormState>();
  final _datepKey = GlobalKey<FormState>();
  final _dtimeKey = GlobalKey<FormState>();
  final _dtimepKey = GlobalKey<FormState>();
  final _atimeKey = GlobalKey<FormState>();
  final _atimepKey = GlobalKey<FormState>();
  final _priceKey = GlobalKey<FormState>();
  String destination = '';
  String departure = '';
  double lat = 0;
  double long = 0;
  String price = '';
  String date = '';
  String day = '';
  String month = '';
  String year = '';

  String dtime = '';
  String dtimeHour = '';
  String dtimeMinute = '';

  String atime = '';
  String atimeHour = '';
  String atimeMinute = '';
  Position? currentPosition;
  int index = 0;
  List<Placemark>? _nearbyLocations;
  List<Placemark>? _suggestedLocations=[];
  @override
  void initState() {
    super.initState();

_getNearByLocations();
destinationController.addListener(() {
      _getSuggestedLocations(destinationController.text);
    });
  }
  void _getNearByLocations() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await GeocodingPlatform.instance.placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _nearbyLocations = placemarks;
    });
  }

  
  Future<void> getCurrentLocation() async {
  var currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  lat = currentPosition.latitude;
   long = currentPosition.longitude;
  var placemark = await GeocodingPlatform.instance.placemarkFromCoordinates(lat,long);
  var firstplacemark = placemark.first;
  setState(() {
    departure = "${firstplacemark.locality}, ${firstplacemark.administrativeArea}";
    departureController.text = "${firstplacemark.locality}, ${firstplacemark.administrativeArea}";
  });
}
void _getSuggestedLocations(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestedLocations = [];
      });
      return;
    }

    var addresses = await GeocodingPlatform.instance.locationFromAddress(query);
    var placemark = await GeocodingPlatform.instance.placemarkFromCoordinates(addresses[0].latitude,addresses[0].longitude);
    setState(() {
      _suggestedLocations=placemark;
    });
  }

  void publishRide() {
    RideModel rideModel = RideModel(
        drivername: widget.drivername,
        driverid: widget.driverid,
        phone: widget.phone,
        destination: destination,
        departure: departure,
        lat: lat,
        long: long,
        price: price,
        age: '21',
        date: '$day/$month/$year',
        dTime: '$dtimeHour:$dtimeMinute',
        aTime: '$atimeHour:$atimeMinute');
    ref.read(rideAPIProvider).saveRideData(context, rideModel);
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
                index == 1
                    ? index = 0
                    : index == 2
                        ? index = 1
                        : index == 3
                            ? index = 2
                            : index == 4
                                ? index = 3
                                : index == 5
                                    ? index = 4
                                    : index == 6
                                        ? index = 5
                                        : Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(
                                                            widget.driverid)),
                                                (route) => false);
              });
            },
            icon: const Icon(CupertinoIcons.back),
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: index == 0
                ? Stack(
                  children: [
                    SingleChildScrollView(
                      
                      child: Column(
                        children: [
                          const Text(
                            "Where are you setting off from on your next adventure?",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 0.5,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _departKey,
                            child: TextFormField(
                              controller: departureController,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (departure.isEmpty) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  departure = val;
                                });
                              },
                              onEditingComplete: () {
                                if (_departKey.currentState!.validate()) {
                                  setState(() {
                                    index = 1;
                                  });
                                }
                              },
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: departure.isEmpty?'Departure':departure,
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: ()async{
                              await getCurrentLocation();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(42, 225, 220, 236),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.locationCrosshairs,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Use Current Location',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyRides(widget.driverid)));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(42, 225, 220, 236),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Spacer(),
                                    Icon(
                                      FontAwesomeIcons.car,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'View Your Rides',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Icon(CupertinoIcons.forward,color: Colors.grey,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          _nearbyLocations==null?const SizedBox.shrink():
                             Row(
                               children:const [
                                  Text('Nearby Locations:',textAlign: TextAlign.start, style: TextStyle(color: Colors.grey),),
                               ],
                             ),
                          const SizedBox(height: 10,),
                          _nearbyLocations==null?const SizedBox.shrink():ListView.builder(
                            itemCount: _nearbyLocations!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              Placemark placemark = _nearbyLocations![0];
                              return InkWell(
                            onTap: (){
                              setState(() {
                                departure='${placemark.name}, ${placemark.subLocality}';
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(42, 225, 220, 236),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                  
                                   const Icon(
                                      FontAwesomeIcons.clockRotateLeft,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                   const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${placemark.name}, ${placemark.subLocality}',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                    
                                    
                                  ],
                                ),
                              ),
                            ),
                          );
                            },
                          ),
                          // const Spacer(),
                          
                        ],
                      ),
                    ),
                    departure.isNotEmpty
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
                                          index = 1;
                                        });
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.check_mark,
                                        color: Colors.green,
                                      ))),
                            )
                          : const SizedBox.shrink(),
                  ],
                )
                : index == 1
                    ? Stack(
                      children: [
                        SingleChildScrollView(
                          
                          child: Column(
                            children: [
                              const Text(
                                "Sounds like you're on the move! Where are you headed?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _arrivalKey,
                                child: TextFormField(
                                  controller: destinationController,
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (destination.isEmpty) {
                                      return 'Please enter Destination';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      destination = val;
                                    });
                                  },
                                  onEditingComplete: () {
                                    if (_arrivalKey.currentState!.validate()) {
                                      setState(() {
                                        index = 2;
                                      });
                                    }
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText:  'Destination',
                                    hintStyle: const TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              _suggestedLocations==null?const SizedBox.shrink():ListView.builder(
                            itemCount: _suggestedLocations!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              Placemark placemark = _suggestedLocations![0];
                              return InkWell(
                            onTap: (){
                              setState(() {
                                destination='${placemark.subLocality}, ${placemark.locality}';
                                destinationController.text='${placemark.subLocality}, ${placemark.locality}';
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(42, 225, 220, 236),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                  
                                   const Icon(
                                      FontAwesomeIcons.clockRotateLeft,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                   const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${placemark.subLocality}, ${placemark.locality}',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                    
                                    
                                  ],
                                ),
                              ),
                            ),
                          );
                            },
                          ),
                              
                            ],
                          )
                        ),
                        destination.isNotEmpty
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            46, 158, 158, 158),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              index = 2;
                                            });
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
                              const Text(
                                "Share the date and let the countdown begin!",
                                style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _dateKey,
                                child: TextFormField(
                                  controller: dateController,
                                  readOnly: true,
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (date.toString().isEmpty) {
                                      return 'Please enter Date';
                                    }
                                    return null;
                                  },
                                  onEditingComplete: () {
                                    if (_dateKey.currentState!.validate()) {
                                      setState(() {
                                        index = 3;
                                      });
                                    }
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: date.isEmpty
                                        ? 'Date'
                                        : '$day/$month/$year',
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              date.toString().isNotEmpty
                                  ? Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                46, 158, 158, 158),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  index = 3;
                                                });
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.check_mark,
                                                color: Colors.green,
                                              ))),
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 4,
                                child: CupertinoTheme(
                                  data: const CupertinoThemeData(
                                    textTheme: CupertinoTextThemeData(
                                      dateTimePickerTextStyle: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  child: CupertinoDatePicker(
                                      key: _datepKey,
                                      mode: CupertinoDatePickerMode.date,
                                      minimumDate: DateTime.now(),
                                      onDateTimeChanged: (DateTime val) {
                                        setState(() {
                                          date = val.day.toString() +
                                              val.month.toString() +
                                              val.year.toString();
                                          day = val.day.toString();
                                          month = val.month.toString();
                                          year = val.year.toString();
                                        });
                                      }),
                                ),
                              )
                            ],
                          )
                        : index == 3
                            ? Column(
                                children: [
                                  const Text(
                                    "What time are you planning on setting off on your adventure?",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 0.5,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                    key: _dtimeKey,
                                    child: TextFormField(
                                      controller: dtimeController,
                                      readOnly: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      validator: (value) {
                                        if (dtime.toString().isEmpty) {
                                          return 'Please enter Time';
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () {
                                        if (_dtimeKey.currentState!
                                            .validate()) {
                                          setState(() {
                                            index = 4;
                                          });
                                        }
                                      },
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        hintText: dtime.isEmpty
                                            ? 'Depature Time'
                                            : '$dtimeHour:$dtimeMinute',
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  dtime.toString().isNotEmpty
                                      ? Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    46, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      index = 4;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    CupertinoIcons.check_mark,
                                                    color: Colors.green,
                                                  ))),
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    child: CupertinoTheme(
                                      data: const CupertinoThemeData(
                                        textTheme: CupertinoTextThemeData(
                                          dateTimePickerTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      child: CupertinoDatePicker(
                                          key: _dtimepKey,
                                          mode: CupertinoDatePickerMode.time,
                                          minimumDate: DateTime.now(),
                                          onDateTimeChanged: (DateTime val) {
                                            setState(() {
                                              dtime = val.toString();
                                              dtimeHour = val.hour.toString();
                                              dtimeMinute =
                                                  val.minute.toString();
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              )
                            : index == 4
                                ? Column(
                                    children: [
                                      const Text(
                                        "What time do you expect to arrive at your destination?",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            letterSpacing: 0.5,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Form(
                                        key: _atimeKey,
                                        child: TextFormField(
                                          controller: atimeController,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          validator: (value) {
                                            if (atime.toString().isEmpty) {
                                              return 'Please enter Arrival Time';
                                            }
                                            return null;
                                          },
                                          onEditingComplete: () {
                                            if (_atimeKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                index = 5;
                                              });
                                            }
                                          },
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            hintText: atime.isEmpty
                                                ? 'Arrival Time'
                                                : '$atimeHour:$atimeMinute',
                                            hintStyle: const TextStyle(
                                                color: Colors.white),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      atime.toString().isNotEmpty
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        46, 158, 158, 158),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          index = 5;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        CupertinoIcons
                                                            .check_mark,
                                                        color: Colors.green,
                                                      ))),
                                            )
                                          : const SizedBox.shrink(),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: CupertinoTheme(
                                          data: const CupertinoThemeData(
                                            textTheme: CupertinoTextThemeData(
                                              dateTimePickerTextStyle:
                                                  TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                            ),
                                          ),
                                          child: CupertinoDatePicker(
                                              key: _atimepKey,
                                              mode:
                                                  CupertinoDatePickerMode.time,
                                              minimumDate: DateTime.now(),
                                              onDateTimeChanged:
                                                  (DateTime val) {
                                                setState(() {
                                                  atime = val.toString();
                                                  atimeHour =
                                                      val.hour.toString();
                                                  atimeMinute =
                                                      val.minute.toString();
                                                });
                                              }),
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      const Text(
                                        "Is it a budget-friendly option or are you splurging for a luxurious experience?",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            letterSpacing: 0.5,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Form(
                                        key: _priceKey,
                                        child: TextFormField(
                                          controller: priceController,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (price.isEmpty) {
                                              return 'Please enter Destination';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              price = val;
                                            });
                                          },
                                          onEditingComplete: () {
                                            publishRide();
                                          },
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            hintText: 'Price',
                                            hintStyle: const TextStyle(
                                                color: Colors.white),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      price.isNotEmpty
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        46, 158, 158, 158),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        publishRide();
                                                      },
                                                      icon: const Icon(
                                                        CupertinoIcons
                                                            .check_mark,
                                                        color: Colors.green,
                                                      ))),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
          ),
        ));
  }
}
