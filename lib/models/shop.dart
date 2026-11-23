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

  factory Shop.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'address': String address,
        'lat': num lat,
        'long': num long,
      } =>
        Shop(
          id: id,
          name: name,
          address: address,
          lat: lat.toDouble(),
          long: long.toDouble(),
        ),
      _ => throw FormatException('Invalid Shop JSON: $json'),
    };
  }

  @override
  String toString() {
    return 'Shop name: $name, Address: $address.';
  }
}
