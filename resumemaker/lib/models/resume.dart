class Resume {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String summary;

  Resume({
    required this.name,
    this.title = '',
    this.email = '',
    this.phone = '',
    this.summary = '',
  });
}
