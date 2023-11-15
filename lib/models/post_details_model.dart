class PostDetailsModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostDetailsModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) {
    return PostDetailsModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
