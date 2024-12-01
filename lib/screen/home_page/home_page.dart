import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/screen/home_page/settings/settings.dart';
import 'package:maybell_apk/screen/home_page/user_screens/account_screen/bloc/user_account_bloc.dart';
import 'package:maybell_apk/screen/home_page/user_screens/account_screen/bloc/user_account_event.dart';
import 'package:maybell_apk/screen/home_page/user_screens/account_screen/user_account.dart';
import 'package:maybell_apk/screen/home_page/user_screens/activity_screen/activities/activity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/entities/colors.dart';
import '../../data/detect_unauthorized_access/websocket/bloc/websocket_bloc.dart';
import '../../data/detect_unauthorized_access/websocket/bloc/websocket_event.dart';
import '../../data/detect_unauthorized_access/websocket/websocket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WebSocketService webSocketService = WebSocketService();
  late bool _hideNavBar;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Activity(),
    UserAccount(),
    Container(color: Colors.white24), // Placeholder for Videos Screen
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<UserAccountBloc>().add(TriggerUserAccount());
    _initializeWebSocket();
    print("listening for connection");
    _hideNavBar = false;
  }

  Future<void> _initializeWebSocket() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    final userEmail = await _loadUserEmail();
    if (userEmail != null) {
      context.read<WebSocketBloc>().add(InitializeWebSocket(userEmail, androidDeviceInfo.model));
    }
  }

  Future<String?> _loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _hideNavBar
          ? null
          : BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.blackShade,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_sharp),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}





// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maybell_apk/screen/home_page/settings/settings.dart';
// import 'package:maybell_apk/screen/home_page/user_screens/account_screen/bloc/user_account_bloc.dart';
// import 'package:maybell_apk/screen/home_page/user_screens/account_screen/bloc/user_account_event.dart';
// import 'package:maybell_apk/screen/home_page/user_screens/account_screen/user_account.dart';
// import 'package:maybell_apk/screen/home_page/user_screens/activity_screen/activities/activity.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../common/entities/colors.dart';
// import '../../data/detect_unauthorized_access/websocket/bloc/websocket_bloc.dart';
// import '../../data/detect_unauthorized_access/websocket/bloc/websocket_event.dart';
// import '../../data/detect_unauthorized_access/websocket/websocket_service.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final WebSocketService webSocketService = WebSocketService();
//   late PersistentTabController _controller;
//   late bool _hideNavBar;
//
//
//   @override
//   void initState() {
//   super.initState();
//
//   context.read<UserAccountBloc>().add(TriggerUserAccount());
//   _initializeWebSocket();
//   print("listening for connection");
//   _controller = PersistentTabController(initialIndex: 0);
//   _hideNavBar = false;
//   }
//
//
//   Future<void> _initializeWebSocket() async {
//     final deviceInfoPlugin = DeviceInfoPlugin();
//     final androidDeviceInfo = await deviceInfoPlugin.androidInfo;
//     final userEmail = await _loadUserEmail();
//     if (userEmail != null) {
//       context.read<WebSocketBloc>().add(InitializeWebSocket(userEmail, androidDeviceInfo.model));
//     }
//   }
//
//   Future<String?> _loadUserEmail() async {
//     SharedPreferences prefs = await  SharedPreferences.getInstance();
//
//     // Load user email from your authentication logic
//     return prefs.getString("user_email");
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(),
//         ],
//       ),
//       bottomNavigationBar: PersistentTabView(
//         context,
//         controller: _controller,
//         screens: [
//           Activity(),
//           //Container(color: Colors.red), // Home Screen
//           UserAccount(), // Details Screen
//           Container(color: Colors.white24), // Videos Screen
//           Settings(), // Settings Screen
//         ],
//         items: [
//           PersistentBottomNavBarItem(
//             icon: Icon(Icons.home),
//             //title: 'Home',
//             activeColorPrimary: AppColors.mainColor,
//               inactiveColorPrimary: AppColors.blackShade
//           ),
//           PersistentBottomNavBarItem(
//             icon: Icon(Icons.event_note_sharp),
//             //title: 'Details',
//             activeColorPrimary: AppColors.mainColor,
//               inactiveColorPrimary: AppColors.blackShade
//           ),
//           PersistentBottomNavBarItem(
//             icon: Icon(Icons.video_library),
//             //title: 'Videos',
//             activeColorPrimary: AppColors.mainColor,
//             inactiveColorPrimary: AppColors.blackShade
//           ),
//           PersistentBottomNavBarItem(
//             icon: Icon(Icons.settings),
//             //title: 'Settings',
//             activeColorPrimary:AppColors.mainColor,
//               inactiveColorPrimary: AppColors.blackShade
//           ),
//         ],
//         confineInSafeArea: true,
//         backgroundColor: Colors.white,
//         handleAndroidBackButtonPress: true,
//         resizeToAvoidBottomInset: true,
//         stateManagement: true,
//         hideNavigationBar: _hideNavBar, // Pass the _hideNavBar value here
//         hideNavigationBarWhenKeyboardShows: true,
//         margin: EdgeInsets.all(0.0),
//         popActionScreens: PopActionScreensType.all,
//         bottomScreenMargin: 0.0,
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           colorBehindNavBar: Colors.white,
//         ),
//         popAllScreensOnTapOfSelectedTab: true,
//         itemAnimationProperties: ItemAnimationProperties(
//           duration: Duration(milliseconds: 200),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: ScreenTransitionAnimation(
//           animateTabTransition: true,
//           curve: Curves.ease,
//           duration: Duration(milliseconds: 200),
//         ),
//         navBarStyle: NavBarStyle.style3,
//       ),
//     );
//   }
// }
