import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/data/data_sources/remote_data_sources/episode/get_episodes.dart';
import 'package:rick_and_morty/src/data/models/character.dart';
import 'package:rick_and_morty/src/data/models/episode.dart';

class CharcrerView extends StatefulWidget {
  final Character character;
  const CharcrerView({super.key, required this.character});

  @override
  State<CharcrerView> createState() => _CharcrerViewState();
}

class _CharcrerViewState extends State<CharcrerView> {
  List<Episode> episodes = [];
  @override
  void initState() {
    loadEpisodes();
    super.initState();
  }
  Future<void> loadEpisodes() async {
    List<String> ids = widget.character.episode.map((e) => e.split('/').last).toList();
    final episode = await EpisodeService().getListOfEpisodes(ids);
      setState(() {
        episodes=episode;
      });
  }
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text(widget.character.name)),
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
                    image: NetworkImage(widget.character.image),
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
                      Text(widget.character.status),
                    ],
                   ),
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Species"),
                      Text(widget.character.species),
                    ],
                   ),
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Gender"),
                      Text(widget.character.gender),
                    ],
                   ),
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Type"),
                      Text(widget.character.type),
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
                Text("Home planet: ${widget.character.origin.name}"),
               Text("Location: ${widget.character.location.name},"),
               ],),
             ),
              Text("Episodes:"),
              Expanded(child: ListView.builder(
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(episodes[index].episode),
                    subtitle: Text(episodes[index].name),
                  );
                },
              )),
            ],
          );
        },  
      ),
    );
  }
}
