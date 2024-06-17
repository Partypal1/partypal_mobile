class Place{
  final String id;
  final String name;
  final String type;
  final String imageURL;
  final DateTime openingTime;
  final DateTime closingTime;
  
  Place({
    required this.id,
    required this.name,
    required this.type,
    required this.imageURL,
    required this.openingTime,
    required this.closingTime,

  });

  static Place fromMap(String id, Map<String, dynamic> data){
    return Place(
      id: id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      imageURL: data['imageURL'] ?? '',
      openingTime:  DateTime.tryParse(data['openingTime'] ?? '') ?? DateTime.now(),
      closingTime:  DateTime.tryParse(data['closingTime'] ?? '') ?? DateTime.now()
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'type': type,
      'imageURL': imageURL,
      'openingTime': openingTime.toIso8601String(),
      'closingTime': closingTime.toIso8601String()
    };
  }
}