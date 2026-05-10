class Novel {
  final String id;
  final String title;
  final String author;
  final String imageUrl;

  Novel({required this.id, required this.title, required this.author, required this.imageUrl});
}

class NovelService {
  static Future<List<Novel>> getNovels() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Novel(id: '1', title: 'Ciudad de huesos', author: 'Michael Connelly', imageUrl: 'https://via.placeholder.com/150'),
      Novel(id: '2', title: 'El despertar del leviatán', author: 'James Corey', imageUrl: 'https://via.placeholder.com/150'),
      Novel(id: '3', title: 'El mejor error de Anna', author: 'Marian Keyes', imageUrl: 'https://via.placeholder.com/150'),
      Novel(id: '4', title: 'Divergente', author: 'Verónica Roth', imageUrl: 'https://via.placeholder.com/150'),
    ];
  }
}