import 'dart:async';
import 'package:advexam/app/home/appointments/edit_appointment_page.dart';
import 'package:advexam/app/home/appointments/list_item_builder.dart';
import 'package:advexam/app/home/models/appointment.dart';
import 'package:advexam/common_widgets/platform_exception_alert_dialog.dart';
import 'package:advexam/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:advexam/app/home/models/entry.dart';
import 'entry_list_item.dart';
import 'entry_page.dart';


class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({@required this.database, @required this.appointment});
  final Database database;
  final Appointment appointment;

  static Future<void> show(BuildContext context, Appointment appointment) async {
    final Database database = Provider.of<Database>(context,listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => JobEntriesPage(database: database, appointment: appointment,),
      )
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Appointment>(
      stream: database.appoinmentStream(appoinmentId: appointment.id),
      builder: (context, snapshot) {
        final appointment = snapshot.data;
        final appointmentName = appointment?.name??'';
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: Text(appointmentName),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                onPressed: () => EditAppointmentPage.show(context, database: database ,appointment: appointment),
              ),
            ],
          ),
          body: _buildContent(context, appointment),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () =>
                EntryPage.show(context: context, database: database, appointment: appointment),
          ),
        );
      }
    );
  }

  Widget _buildContent(BuildContext context, Appointment appointment) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(appointment: appointment),
      builder: (context, snapshot) {
        return ListItemBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              appointment: appointment,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                appointment: appointment,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
