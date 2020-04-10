import 'package:advexam/app/home/models/appointment.dart';
import 'package:flutter/material.dart';

class aptListTile extends StatelessWidget {
  const aptListTile({Key key,@required this.appointment, this.onTap}) : super(key: key);
  final Appointment appointment;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.chevron_right),
      title: Text(appointment.name),
      onTap:onTap ,
    );
  }
}
