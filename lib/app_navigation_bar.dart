////////////////////////////////////////////////////////////////////////////////////////////
/// import
////////////////////////////////////////////////////////////////////////////////////////////
library;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robo_debug_app/components/style.dart';

////////////////////////////////////////////////////////////////////////////////////////////
/// App Widget
////////////////////////////////////////////////////////////////////////////////////////////
class AppNavigationBar extends ConsumerWidget {
  const AppNavigationBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;
  int get currentIndex => navigationShell.currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      resizeToAvoidBottomInset: currentIndex == 0 ? false : true,
      body: navigationShell,
      drawer: isLandscape ? Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            ListTile(
              leading: const Icon(Icons.car_rental, size: 28),
              title: const Text('Motor'),
              onTap: () => navigationShell.goBranch(0),
            ),
            ListTile(
              leading: const Icon(Icons.chat, size: 28),
              title: const Text('Console'),
              onTap: () => navigationShell.goBranch(1),
            ),
            ListTile(
              leading: const Icon(Icons.gamepad, size: 28),
              title: const Text('Joystick'),
              onTap: () => navigationShell.goBranch(2),
            ),
            ListTile(
              leading: const Icon(Icons.settings, size: 28),
              title: const Text('Parameters'),
              onTap: () => navigationShell.goBranch(3),
            ),
          ],
        ),
      ) : null,
      bottomNavigationBar: !isLandscape ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        onTap: (index) async {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental, size: 24),
            activeIcon: Icon(Icons.car_rental, size: 28),
            label: 'Motor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 24),
            activeIcon: Icon(Icons.chat, size: 28),
            label: 'Console',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad, size: 24),
            activeIcon: Icon(Icons.gamepad, size: 28),
            label: 'Joystick',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 24),
            activeIcon: Icon(Icons.settings, size: 28),
            label: 'Parameters',
          ),
        ],
        fixedColor: Styles.primaryColor,
      ) : null,
    );
    
  }
}
