import 'package:flutter/cupertino.dart';

class Appointment{
  Appointment({this.id,@required this.name, @required this.ratePerHour,} );
  final String id;
  final String name;
  final int ratePerHour;

  factory Appointment.fromMap(Map<String,dynamic> data, String documentId){
    if (data== null)
      {
        return null;
      }
    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];
    return Appointment(
      id: documentId,
      name: name,
      ratePerHour: ratePerHour
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}