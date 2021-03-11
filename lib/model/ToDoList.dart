class Todolist {
  int id;
  String title;
  String lable;

  int userId;
  String description;
  String completedAt;
  String createdAt;
  String updatedAt;
  bool checked = false;
  bool expanded = false;
  Todolist(
      {this.id,
        this.title,
        this.userId,
        this.description,
        this.completedAt,
        this.createdAt,
        this.updatedAt});

  Todolist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['user_id'];
    description = json['description'];
    completedAt = json['completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['completed_at'] = this.completedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}