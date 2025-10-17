import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/presentation/pages/favorites_page.dart';
import 'package:rick_and_morty/src/presentation/pages/home_page.dart';

class AppGate extends StatefulWidget {
  
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  int currentIndex =0; 
  int currentPage =1;
  void onPageChanged(int value){
    setState(() {
      currentPage = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[
    HomePage(
      currentPage: currentPage,
      onPageChanged: onPageChanged,
    ),
    FavoritesPage()
  ];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => setState(()=>currentIndex = value),
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.star)),
        ]),
    );
  }
}

