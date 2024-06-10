class Folder {
  final String name;
  final String description;
  // final int quantity;

  Folder(this.name, this.description);

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        // 'quantity': quantity,
      };

  static Folder fromJson(Map<String, dynamic> json) => Folder(
        json['name'],
        json['description'],
        // json['quantity'],
      );
}
