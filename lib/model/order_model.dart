class Order {
  final int id;
  final String imagePath;
  final String title;
  final double price;
  final String category;
  final DateTime orderTime;

  Order({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.category,
    required this.orderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'price': price,
      'category': category,
      'orderTime': orderTime.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      imagePath: map['imagePath'],
      title: map['title'],
      price: map['price'],
      category: map['category'],
      orderTime: DateTime.parse(map['orderTime']),
    );
  }
}
