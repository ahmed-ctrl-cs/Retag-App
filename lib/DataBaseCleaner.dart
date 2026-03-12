import 'package:cloud_firestore/cloud_firestore.dart';

class Databasecleaner {
  Future<void> databasecleaner() async {
    try {
      DateTime clean = DateTime.now().subtract(const Duration(days: 37));

      QuerySnapshot OldReservations = await FirebaseFirestore.instance
          .collection('reservations')
          .where('time_stamp', isLessThan: clean)
          .get();

      for (var doc in OldReservations.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error cleaning database: $e');
    }
  }
}
