class Post {
  final String? pk;
  final String? title;
  final String? content;
  final DateTime? createdDate;
  final String? userId;

  Post(
      {this.pk,
        this.title,
        this.content,
        this.createdDate,
        this.userId});
}