import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            Container(
              height: 30,
              color: Colors.blueAccent,
            ),
            UserAccountsDrawerHeader(
              margin: EdgeInsets.all(0),
              accountEmail: Text("david@gmail.com"),
              accountName: Text("David Dev"),
              currentAccountPicture: Icon(
                Icons.supervised_user_circle,
                color: Colors.grey,
                size: 50,
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              onTap: () {},
              title: Text("My Order"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            ListTile(
              leading: Icon(Icons.translate),
              onTap: () {},
              title: Text("Language"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              onTap: () {},
              title: Text("Setting"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            ListTile(
              leading: Icon(Icons.error),
              onTap: () {},
              title: Text("About Us"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
