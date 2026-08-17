import 'package:flutter/material.dart';
import '../theme.dart';
import '../screens/home_screen.dart';
import '../screens/program_list_screen.dart';

/// Shared bottom navigation used on Home / Explore so the four core
/// screens (Login, Home, Program List, Program Details) all feel connected.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  void _go(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProgramListScreen()),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This section is coming soon.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex.clamp(0, 3),
      onTap: (i) => _go(context, i),
      selectedItemColor: AppColors.ink,
      unselectedItemColor: AppColors.muted,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore_rounded), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'My Learning'),
        BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
    );
  }
}
