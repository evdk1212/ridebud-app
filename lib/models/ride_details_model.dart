import 'package:flutter/foundation.dart';

class RideModel {
  final String drivername;
  final String driverid;
  final String phone;
  final String destination;
  final String departure;
  final double lat;
  final double long;
  final String price;
  final String age;
  final String date;
  final String dTime;
  final String aTime;

  const RideModel({
    required this.drivername,
    required this.driverid,
    required this.phone,
    required this.destination,
    required this.departure,
    required this.lat,
    required this.long,
    required this.price,
    required this.age,
    required this.date,
    required this.dTime,
    required this.aTime,
  });

  RideModel copyWith({
    String? drivername,
    String? driverid,
    String? phone,
    String? destination,
    String? departure,
    double? lat,
    double? long,
    String? price,
    String? age,
    String? dTime,
    String? aTime,
    String? date,
  }) {
    return RideModel(
      drivername: drivername ?? this.drivername,
      driverid: driverid ?? this.driverid,
      phone: phone ?? this.phone,
      destination: destination ?? this.destination,
      departure: departure ?? this.departure,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      price: price ?? this.price,
      age: age ?? this.age,
      dTime: dTime ?? this.dTime,
      aTime: aTime ?? this.aTime,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'drivername': drivername});
    result.addAll({'driverid': driverid});
    result.addAll({'phone': phone});
    result.addAll({'destination': destination});
    result.addAll({'departure': departure});
    result.addAll({'lat': lat});
    result.addAll({'long': long});
    result.addAll({'price': price});
    result.addAll({'age': age});
    result.addAll({'date': date});
    result.addAll({'dTime': dTime});
    result.addAll({'aTime': aTime});

    return result;
  }

  factory RideModel.fromMap(Map<String, dynamic> map) {
    return RideModel(
      drivername: map['drivername'] ?? '',
      driverid: map['driverid'] ?? '',
      phone: map['phone'] ?? '',
      destination: map['destination'] ?? '',
      departure: map['departure'] ?? '',
      lat: map['lat'] ?? '',
      long: map['long'] ?? '',
      price: map['price'] ?? '',
      age: map['age'] ?? '',
      date: map['date'] ?? '',
      dTime: map['dTime'] ?? '',
      aTime: map['aTime'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RideModel(drivername: $drivername, driverid: $driverid,  phone: $phone, destination: $destination, departure: $departure, lat: $lat, long: $long,price: $price, age: $age,date: $date,dTime: $dTime,aTime: $aTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RideModel &&
        other.drivername == drivername &&
        other.driverid == driverid &&
        other.phone == phone &&
        other.destination == destination &&
        other.departure == departure &&
        other.lat == lat &&
        other.long == long &&
        other.price == price &&
        other.age == age &&
        other.date == date &&
        other.dTime == dTime &&
        other.aTime == aTime;
  }

  @override
  int get hashCode {
    return drivername.hashCode ^
        driverid.hashCode ^
        phone.hashCode ^
        destination.hashCode ^
        departure.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        price.hashCode ^
        age.hashCode ^
        date.hashCode ^
        dTime.hashCode ^
        aTime.hashCode;
  }
}
