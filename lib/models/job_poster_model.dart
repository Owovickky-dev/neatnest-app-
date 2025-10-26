class JobPosterModel {
  final String id;
  final String name;
  final String username;

  JobPosterModel({this.id = "", this.name = "", this.username = ""});

  factory JobPosterModel.fromJson(Map<String, dynamic> json) {
    return JobPosterModel(
      id: json['_id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      username: json['username']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'username': username};
  }
}
