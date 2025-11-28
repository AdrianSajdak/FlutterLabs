import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista 4 przykładowych obrazków z sieci
    final List<String> imageUrls = [
      'https://picsum.photos/id/101/300/300',
      'https://picsum.photos/id/102/300/300',
      'https://picsum.photos/id/103/300/300',
      'https://picsum.photos/id/104/300/300',
    ];

    return GridView.count(
      // Tworzy siatkę z 2 kolumnami
      crossAxisCount: 2,
      // Padding wokół całej siatki
      padding: const EdgeInsets.all(12.0),
      // Odstępy między kafelkami
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
      // Budowanie 4 kafelków na podstawie listy imageUrls
      children: imageUrls.map((url) => _GridItem(imageUrl: url)).toList(),
    );
  }
}

// Prywatny widget pomocniczy dla pojedynczego elementu siatki
class _GridItem extends StatelessWidget {
  final String imageUrl;

  const _GridItem({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0), // Zaokrąglone rogi
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover, // Wypełnienie całego kafelka
        // Wskaźnik ładowania podczas pobierania obrazka
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        // Placeholder w razie błędu ładowania
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade300,
            child: Icon(
              Icons.broken_image,
              color: Colors.grey.shade700,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}