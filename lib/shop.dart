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

  factory Shop.fromJson(Map<String, dynamic> data) {
    const requiredKeys = ['id', 'name', 'address', 'lat', 'long'];
    for (final key in requiredKeys) {
      if (!data.containsKey(key)) {
        throw FormatException('Shop JSON missing "$key"');
      }
      if (data[key] == null) {
        throw FormatException('Shop JSON "$key" field is null');
      }
    }

    return Shop(
      id: data['id'] as int,
      name: data['name'] as String,
      address: data['address'] as String,
      lat: (data['lat'] as num).toDouble(),
      long: (data['long'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Shop name: $name, Address: $address.';
  }
}
