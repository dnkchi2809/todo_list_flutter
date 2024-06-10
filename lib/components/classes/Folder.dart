class Folder {
  final String name;
  final String description;

  Folder(this.name, this.description);

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
  };

  static Folder fromJson(Map<String, dynamic> json) => Folder(
    json['name'],
    json['description'],
  );
}