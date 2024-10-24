class Access {

  final String id;
  final bool access;
  final DateTime timestamp;
  final double latitude;
  final double longitude;

  Access({
    required this.id,
    required this.access,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
  });

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'access': access,
      'timestamp': timestamp.toIso8601String(),
      'location': {
        'latitude': latitude,
        'longitude': longitude,
      }
    };
  }

  //fromMap
  factory Access.fromMap(Map<String, dynamic> map, String doc) {
    return Access(
      id: doc,
      access: map['access'],
      timestamp: DateTime.parse(map['timestamp']),
      latitude: map['location']['latitude'],
      longitude: map['location']['longitude'],
    );
  }
}