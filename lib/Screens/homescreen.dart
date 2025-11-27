import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import '../Screens/home_page.dart';
import '../Screens/slot_page.dart';
import '../Screens/history_page.dart';
import '../Screens/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loading = true;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Slotpage(),
    HistoryPage(),
    ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.transparent, // Transparent background
            // appBar: AppBar(
            //   iconTheme: IconThemeData(color: Colors.black),
            //   title: const Text(
            //     "Parking System",
            //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            //   ),
            //
            //   backgroundColor:Colors.white24, //Color(0xFFFDFBD4),
            //   foregroundColor: Colors.white,
            //   elevation: 50.0,
            //   systemOverlayStyle: SystemUiOverlayStyle.light,
            // ),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: _page,
              items: <Widget>[
                Icon(Icons.home_outlined, size: 30, color: Colors.black),
                Icon(Icons.local_parking, size: 30, color: Colors.black),
                Icon(Icons.analytics_outlined, size: 30, color: Colors.black),
                Icon(Icons.account_circle_outlined, size: 30, color: Colors.black),
              ],
              color:Colors.yellow,
              buttonBackgroundColor: Colors.yellowAccent,
              backgroundColor: Colors.white, // Transparent nav curve
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  _page = index;
                });
              },
              letIndexChange: (index) => true,
            ),

            // drawer: Drawer(
            //   child: DrawerWidget(
            //     onProfileTap: () {
            //       setState(() {
            //         _page = 4; // navigate to profile
            //       });
            //     },
            //   ),
            // ),

            body:   Center(child: _widgetOptions.elementAt(_page))
          //   body: loading
          //     ? const Center(child: CircularProgressIndicator())
          //     : contacts == null
          //     ? const Center(child: Text('Failed to load contacts'))
          //     : ListView.builder(
          //   itemCount: contacts!.length,
          //   itemBuilder: (context, index) {
          //     final c = contacts![index];
          //     return ListTile(
          //       title: Text(c['full_name'] ?? 'No Name'),
          //       subtitle: Text(c['phone_e164']),
          //     );
          //   },
          // ),
        )
      ],
    );
  }
}
