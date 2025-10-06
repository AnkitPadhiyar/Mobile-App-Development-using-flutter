class Question {
  // Optional local asset path (e.g. 'assets/images/apple.png'). If provided
  // the app will try to load the asset first and fall back to `networkUrl`.
  final String? assetPath;
  // Network URL fallback
  final String networkUrl;
  final String correct; // correct spelling
  final List<String> options; // options (including correct)

  Question({
    this.assetPath,
    required this.networkUrl,
    required this.correct,
    required this.options,
  });
}
