class ListingCreateDto {
  final String title;
  final String imageUrl;
  final double trueCoinValue;
  final String? description;
  final String? address;
  final double latitude;
  final double longitude;

  ListingCreateDto({
    required this.title,
    required this.imageUrl,
    required this.trueCoinValue,
    this.description,
    this.address,
    required this.latitude,
    required this.longitude,
  });

  factory ListingCreateDto.fromJson(Map<String, dynamic> json) {
    return ListingCreateDto(
      title: json['title'],
      imageUrl: json['imageUrl'],
      trueCoinValue: (json['trueCoinValue'] as num).toDouble(),
      description: json['description'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'imageUrl': imageUrl,
    'trueCoinValue': trueCoinValue,
    'description': description,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
  };
}
