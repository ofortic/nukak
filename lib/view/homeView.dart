import 'package:nukak/view/FavoriteView.dart';
import 'package:nukak/view/ProfileView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 1;
  final List<Widget> _children = [ProfileView(), HomeView(), FavoriteView()];
  final tabs = [
    Center(child: Text('Profile')),
    Center(child: Text('Home')),
    Center(child: Text('Favorites')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nukak'),
        backgroundColor: Color(0xFFFF8F00),
      ),
      body: tabs[_currentIndex],
      //body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        backgroundColor: Color(0xFFFFFFFF),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.amber.withOpacity(.80),
        selectedFontSize: 16,
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: ImageIcon(AssetImage('assets/images/icon_profile.png')),
          ),
          BottomNavigationBarItem(
            label: 'Inicio',
            icon: ImageIcon(AssetImage('assets/images/icon_home.png')),
          ),
          BottomNavigationBarItem(
            label: 'Favoritos',
            icon: ImageIcon(AssetImage('assets/images/icon_favs.png')),
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
