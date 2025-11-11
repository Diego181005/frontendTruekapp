// lib/dto/listing/listing_update_dto.dart
class ListingUpdateDto {
  final String? title;
  final String? description;
  final double? trueCoinValue;
  final String? imageUrl;
  final bool? isPublished;
  final double? latitude;
  final double? longitude;

  ListingUpdateDto({
    this.title,
    this.description,
    this.trueCoinValue,
    this.imageUrl,
    this.isPublished,
    this.latitude,
    this.longitude,
  });

  factory ListingUpdateDto.fromJson(Map<String, dynamic> json) {
    return ListingUpdateDto(
      title: json['title'],
      description: json['description'],
      trueCoinValue: json['trueCoinValue'] != null
          ? (json['trueCoinValue'] as num).toDouble()
          : null,
      imageUrl: json['imageUrl'],
      isPublished: json['isPublished'],
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'trueCoinValue': trueCoinValue,
    'imageUrl': imageUrl,
    'isPublished': isPublished,
    'latitude': latitude,
    'longitude': longitude,
  };
}
