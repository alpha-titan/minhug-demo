import 'package:advexam/app/home/models/appointment.dart';
import 'package:advexam/common_widgets/platform_alert_dialogue.dart';
import 'package:advexam/common_widgets/platform_exception_alert_dialog.dart';
import 'package:advexam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditAppointmentPage extends StatefulWidget {
  EditAppointmentPage({Key key, @required this.database, this.appointment}) : super(key: key);
  final Database database;
  final Appointment appointment;

  static Future<void> show(BuildContext context,{ Database database ,Appointment appointment}) async {

    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => EditAppointmentPage(database: database, appointment: appointment,),
          fullscreenDialog: true),
    );
  }

  @override
  _EditAppointmentPageState createState() => _EditAppointmentPageState();
}

class _EditAppointmentPageState extends State<EditAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;

  @override
  void initState(){
    super.initState();
    if(widget.appointment!=null){
      _name = widget.appointment.name;
      _ratePerHour=widget.appointment.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final appointments = await widget.database.appointmentsStream().first;
        final allNames = appointments.map((appointment)=>appointment.name).toList();
        if(widget.appointment!=null)
          {
            allNames.remove(widget.appointment.name);
          }
        if(allNames.contains(_name)){
          PlatformAlertDialog(
            title: 'Patient Name Already added',
            content: 'Please check the name again',
            defaultActionText: 'OK',
          ).show(context);
        }
        else {
          final id = widget.appointment?.id??documentIdFromCurrentDate();
          final appointment = Appointment(
            id: id,
            name: _name, ratePerHour: _ratePerHour,);
          await widget.database.setAppointment(appointment);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400].withOpacity(0.6),
        elevation: 2.0,
        title: Text(widget.appointment==null?' New Appointment' : 'Edit'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _submit(),
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child:
              Padding(padding: const EdgeInsets.all(16.0), child: _buildForm()),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'Name is required',
        decoration: InputDecoration(labelText: 'Patient Name'),
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        initialValue: _ratePerHour!=null?'$_ratePerHour': null,
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
        decoration: InputDecoration(labelText: 'COS/ hour'),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
      )
    ];
  }
}
