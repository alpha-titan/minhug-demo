class APIPath {
  static String appointment(String uid, String appointmentId) => '/users/$uid/appointments/$appointmentId';
  static String appointments(String uid) => 'users/$uid/appointments';
  static String entry(String uid, String entryId)=>
      'users/$uid/entries/$entryId';
  static String entries(String uid)=>'users/$uid/entries';
}
