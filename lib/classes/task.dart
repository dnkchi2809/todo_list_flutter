class Task {
  final int taskId;
  final String name;
  final String description;
  final String deadline;
  final String createDate;
  final int status;
  final int folderId;

  Task(
    this.taskId,
    this.name,
    this.description,
    this.deadline,
    this.createDate,
    this.status,
    this.folderId,
  );

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'name': name,
        'description': description,
        'deadline': deadline,
        'createDate': createDate,
        'status': status,
        'folderId': folderId
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
      json['taskId'],
      json['name'],
      json['description'],
      json['deadline'],
      json['createDate'],
      json['status'],
      json['folderId']);
}
