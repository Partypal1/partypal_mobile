class Event{
  final String name;
  final DateTime dateTime;
  final String location;
  final String creator;
  final String imageURL;
  // final bool isLiked;

  Event({
    required this.name,
    required this.dateTime,
    required this.location,
    required this.creator,
    required this.imageURL,
    // required this.isLiked
  });

  static Event fromMap(Map<String, dynamic> data){
    return Event(
      name: data['name'] ?? '',
      dateTime: DateTime.tryParse(data['dateTime'] ?? '') ?? DateTime.now(),
      location: data['location'] ?? '',
      creator: data['creator'] ?? '',
      imageURL: data['imageURL'] ?? ''
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'creator': creator,
      'imageURL': imageURL
    };
  }
}