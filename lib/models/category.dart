class category{
  final String name;
  final String image;
  category({this.name,this.image});

  factory category.fromMap(Map<String, dynamic> data) {
    return category(
      name: data['name'] ?? '',
      image: data['image'] ?? ''
    );
  }
}