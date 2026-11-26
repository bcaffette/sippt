class Shop {
  final int id;
  final String name;
  final String address;
  final double lat;
  final double long;

  Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
  });

  factory Shop.fromJson(json) {
    return Shop(
      id: json['id'] as int,
      name: json['partners']['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Shop(Shop: $name, Address: $address, [$lat, $long])';
  }
}
