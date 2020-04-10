import 'package:advexam/app/home/appointments/edit_appointment_page.dart';
import 'package:advexam/app/home/appointments/apt_list_tile.dart';
import 'package:advexam/app/home/appointments/list_item_builder.dart';
import 'package:advexam/app/home/job_entries/job_entries_page.dart';
import 'package:advexam/app/home/models/appointment.dart';
import 'package:advexam/common_widgets/platform_alert_dialogue.dart';
import 'package:advexam/common_widgets/platform_exception_alert_dialog.dart';
import 'package:advexam/services/auth.dart';
import 'package:advexam/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logot',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ListView(),
      appBar: AppBar(
        backgroundColor: Colors.green[400].withOpacity(0.6),
        title: Text('Appointments'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[400].withOpacity(0.6),
          elevation: 10.0,
          onPressed: () => EditAppointmentPage.show(context,database: Provider.of<Database>(context,listen: false)),
          child: Icon(Icons.add)),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Appointment>>(
      stream: database.appointmentsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Appointment>(
          snapshot: snapshot,
          itemBuilder: (context, appointment) => Dismissible(
            key: Key('appointment-${appointment.id}'),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, appointment),
            child: aptListTile(
              appointment: appointment,
              onTap: () =>
                  JobEntriesPage.show(context,appointment),
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, Appointment appointment) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteAppointment(appointment);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(title: 'Operation Failed', exception: e)
          .show(context);
    }
  }
}
