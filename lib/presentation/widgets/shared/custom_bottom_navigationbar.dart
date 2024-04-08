import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigation extends StatelessWidget {

  final int currentIdex;
  const CustomBottomNavigation({super.key, required this.currentIdex});

  void onItemTapped ( BuildContext context, index) {
    switch(index){
      case 0:
      context.go("/home/0");
      break;
      case 1:
      context.go("/home/1");
      break;
      case 2:
      context.go("/home/2");
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: currentIdex,
      onTap: (index) {
        onItemTapped(context, index);
      },
      elevation: 0,
      //backgroundColor: colors.primary,
      //type: BottomNavigationBarType.shifting,
      items: const [
        BottomNavigationBarItem(
          icon: Icon( Icons.home_outlined ),
          activeIcon: Icon(Icons.home),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.label_outline ),
          label: 'Categorías'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.favorite_outline ),
          label: 'Favoritos'
        ),
      ]
    );
  }
}