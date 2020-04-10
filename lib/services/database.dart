import 'dart:async';

import 'package:advexam/app/home/models/entry.dart';
import 'package:advexam/app/home/models/appointment.dart';
import 'package:meta/meta.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Future<void> setAppointment(Appointment appointment);

  Future<void> deleteAppointment(Appointment appointment);

  Stream<List<Appointment>> appointmentsStream();

  Future<void> setEntry(Entry entry);

  Future<void> deleteEntry(Entry entry);
  Stream<Appointment> appoinmentStream({@required String appoinmentId});

  Stream<List<Entry>> entriesStream({Appointment appointment});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setAppointment(Appointment appointment) async =>
      await _service.setData(
        path: APIPath.appointment(uid, appointment.id),
        data: appointment.toMap(),
      );

  @override
  Future<void> deleteAppointment(Appointment appointment) async {
    // delete where entry.jobId == job.jobId
    final allEntries = await entriesStream(appointment: appointment).first;
    for (Entry entry in allEntries) {
      if (entry.jobId == appointment.id) {
        await deleteEntry(entry);
      }
    }
    // delete job
    await _service.deleteData(path: APIPath.appointment(uid, appointment.id));
  }
  @override
  Stream<Appointment> appoinmentStream({@required String appoinmentId}) =>
      _service.documentStream(
          path: APIPath.appointment(uid, appoinmentId),
          builder: (data, documentId) => Appointment.fromMap(data, documentId));

  @override
  Stream<List<Appointment>> appointmentsStream() =>
      _service.collectionStream(
        path: APIPath.appointments(uid),
        builder: (data, documentId) => Appointment.fromMap(data, documentId),
      );

  @override
  Future<void> setEntry(Entry entry) async =>
      await _service.setData(
        path: APIPath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) async =>
      await _service.deleteData(path: APIPath.entry(uid, entry.id));

  @override
  Stream<List<Entry>> entriesStream({Appointment appointment}) =>
      _service.collectionStream<Entry>(
        path: APIPath.entries(uid),
        queryBuilder: appointment != null ? (query) =>
            query.where('jobId', isEqualTo: appointment.id) : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
