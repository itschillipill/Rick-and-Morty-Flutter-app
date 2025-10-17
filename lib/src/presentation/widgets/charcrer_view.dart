import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/data/data_sources/remote_data_sources/episode/get_episodes.dart';
import 'package:rick_and_morty/src/data/models/character.dart';
import 'package:rick_and_morty/src/data/models/episode.dart';

class CharcrerView extends StatelessWidget {
  final Character character;
  const CharcrerView({super.key, required this.character});

  Future<List<Episode>> loadEpisodes() async {
    List<String> ids = character.episode.map((e) => e.split('/').last).toList();
    return await EpisodeService().getListOfEpisodes(ids);
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(character.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Status"),
                      Text(character.status),
                    ],
                   ),
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Species"),
                      Text(character.species),
                    ],
                   ),
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Gender"),
                      Text(character.gender),
                    ],
                   ),
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Type"),
                      Text(character.type),
                    ],
                   ),
                  ],
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Home planet: ${character.origin.name}"),
               Text("Location: ${character.location.name},"),
               ],),
             ),
              Text("Episodes:"),
              Expanded(child: FutureBuilder(
                future: loadEpisodes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == null || snapshot.hasError) {
                    return Center(child: Text('Error accured, please check your internet connection and try again later.'));
                  }
                  final episodes = snapshot.data!;
                  return ListView.builder(
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(episodes[index].episode),
                        subtitle: Text(episodes[index].name),
                      );
                    },
                  );
                }
              )),
            ],
          );
        },  
      ),
    );
  }
}
