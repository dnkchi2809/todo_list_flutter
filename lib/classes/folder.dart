class Folder {
  final int folderId;
  final String name;
  final String description;
  final List taskIds;

  Folder(this.folderId, this.name, this.description, this.taskIds);

  Map<String, dynamic> toJson() => {
        'folderId': folderId,
        'name': name,
        'description': description,
        'taskIds': taskIds,
      };

  static Folder fromJson(Map<String, dynamic> json) => Folder(
        json['folderId'],
        json['name'],
        json['description'],
        json['taskIds'],
      );
}
