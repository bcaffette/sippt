class Shop {
  final int id;
  final String name;
  final String address;
  final double long;
  final double lat;

  Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.long,
    required this.lat,
  });

  factory Shop.fromJson(Map<String, dynamic> data) {
    return Shop(
      id: data['id'] as int,
      name: data['name'] as String,
      address: data['address'] as String,
      long: (data['long'] as num).toDouble(),
      lat: (data['lat'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Shop name: $name, Address: $address.';
  }
}
