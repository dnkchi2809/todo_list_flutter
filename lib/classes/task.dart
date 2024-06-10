class Task {
  final int taskId;
  final String name;
  final String description;
  final String deadline;
  final String createDate;
  final int folderId;

  Task(this.taskId, this.name, this.description, this.deadline, this.createDate, this.folderId);

  // Map<String, dynamic> toJson() => {
  //   'name': name,
  //   'description': description,
  //   'quantity': quantity,
  // };
  //
  // static Task fromJson(Map<String, dynamic> json) => Task(
  //   json['name'],
  //   json['description'],
  //   json['quantity'],
  // );
}
