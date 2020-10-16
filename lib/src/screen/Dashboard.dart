import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Configuration.colorApp,
          title: Text('Películas'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Configuration.colorApp,
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      NetworkImage('https://thispersondoesnotexist.com/image'),
                  backgroundColor: Colors.transparent,
                ),
                accountName: Text('Saúl Mondragón Ortega JR Programmer'),
                accountEmail: Text('saulmondragonortega@gmail.com'),
                onDetailsPressed: () {},
              ),
              ListTile(
                title: Text('Trending'),
                leading: Icon(
                  Icons.trending_up,
                  color: Configuration.colorItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/trending');
                },
              ),
              ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite_border_outlined,
                  color: Configuration.colorItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/favourites');
                },
              ),
              ListTile(
                title: Text('Search'),
                leading: Icon(
                  Icons.search,
                  color: Configuration.colorItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/search');
                },
              ),
              ListTile(
                title: Text('Profile'),
                leading: Icon(
                  Icons.edit,
                  color: Configuration.colorItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: Text('Sign out'),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Configuration.colorItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
