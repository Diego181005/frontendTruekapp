class ListingDto {
  final int id;
  final String title;
  final double trueCoinValue;
  final bool isPublished;
  final String imageUrl;
  final double latitude;
  final double longitude;

  ListingDto({
    required this.id,
    required this.title,
    required this.trueCoinValue,
    required this.isPublished,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  factory ListingDto.fromJson(Map<String, dynamic> json) {
    return ListingDto(
      id: json['id'],
      title: json['title'],
      trueCoinValue: (json['trueCoinValue'] as num).toDouble(),
      isPublished: json['isPublished'],
      imageUrl: json['imageUrl'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'trueCoinValue': trueCoinValue,
    'isPublished': isPublished,
    'imageUrl': imageUrl,
    'latitude': latitude,
    'longitude': longitude,
  };
}
