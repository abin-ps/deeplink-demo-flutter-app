 final List<Product> productsList = [
    Product(
      id: 1,
      name: 'Computer Glass',
      description: 'Lenskart computer glass. which block blue lights.',
      dateAdded: '10/02/2024',
    ),
    Product(
      id: 2,
      name: 'Amkette Katana Pro Mechanical Keyboard',
      description: 'Best budget mechanical keyboard ever.',
      dateAdded: '10/02/2024',
    ),
    Product(
      id: 2,
      name: 'Amkette Shadow Gaming mouse',
      description: 'Budget Gaming mouse',
      dateAdded: '10/02/2024',
    ),
  ];


  class Product {
  int id;
  String name;
  String description;
  String dateAdded;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.dateAdded,
  });
}