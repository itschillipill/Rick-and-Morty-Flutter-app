import 'package:flutter/material.dart';
import '../../data/models/character.dart';
import 'package:animations/animations.dart';

import 'charcrer_view.dart';


class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
       closedElevation: 4,
        openColor: Colors.transparent,
        closedColor: Colors.transparent,           
                    transitionDuration:
                        const Duration(milliseconds: 300),
                    openBuilder: (context, action) => CharcrerView(character: character),
      closedBuilder: (context, action) => Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              character.image,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 40),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  width: 56,
                  height: 56,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
            ),
          ),
          title: Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(character.species),
              Text(
                character.status,
                style: TextStyle(
                  color: character.status == "Alive"
                      ? Colors.green
                      : character.status == "Dead"
                          ? Colors.red
                          : Colors.grey,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: onFavoriteToggle,
          ),
        ),
      ),
    );
  }
}
