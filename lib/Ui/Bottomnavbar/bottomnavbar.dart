
import 'package:cleanarchitecture_example/Bloc/Bottombar_navigationbloc/bottomnavbar_bloc.dart';
import 'package:flutter/material.dart';


class BottomNavBarApp extends StatefulWidget {
  createState() => _BottomNavBarAppState();
}

class _BottomNavBarAppState extends State<BottomNavBarApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 var bottomNavBarBloc = BottomNavBarBloc() ;

  @override
  void initState() {
    super.initState();
    bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  void dispose() {
    bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        title: Text('Bottom NavBar Navigation'),
      ),
      body: StreamBuilder<NavBarItem>(
        stream: bottomNavBarBloc.itemStream,
        initialData: bottomNavBarBloc.defaultItem,

        builder: (BuildContext ,  snapshot) {
          if (snapshot.hasData){
            return _homeArea();
          }


        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: bottomNavBarBloc.itemStream,
        initialData: bottomNavBarBloc.defaultItem,
        builder: (BuildContext c, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data.index,
            onTap: bottomNavBarBloc.pickItem,
            items: [
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Home'),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Notifications'),
                icon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Settings'),
                icon: Icon(Icons.settings),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _homeArea() {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.green,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _alertArea() {
    return Center(
      child: Text(
        'Notifications Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _settingsArea() {
    return Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
