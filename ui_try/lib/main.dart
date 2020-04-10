import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/images/fest.jpg'),fit: BoxFit.cover ),
              color: Colors.indigoAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 10,
                    child: Row(children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/LW.jpg'),
                        radius: 37.0,
                      ),
                      FlatButton.icon(
                        onPressed: () {},
                        label: Text('Edit Profile',style: TextStyle(color: Colors.white),),
                        icon: Icon(Icons.edit),
                        splashColor: Colors.indigo,
                      )
                    ]),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.grey[200],
                  ),
                  Text('Sachin Ananthakumar', style: TextStyle(color: Colors.white),),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('sa1842@bennett.edu.in',style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Your House'),
              subtitle: Text('rocks!!'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Your Interests'),
              subtitle: Text('check it out'),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: Text('College Diaries'),
          backgroundColor: Colors.indigo,
          elevation: 20.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
                label: Text('Logout')),
          ]),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    buildHighlightContainer('assets/images/writing.jpg'),
                    buildHighlightContainer('assets/images/party.jpg'),
                    buildHighlightContainer('assets/images/dance.jpg'),
                    buildHighlightContainer('assets/images/sports.jpg'),

                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Explore Talents",
                      style: TextStyle(fontSize: 20.0,
                          fontFamily: 'Dancing',
                          fontWeight: FontWeight.bold),

                    ),
                    SizedBox(height: 8.0,),

                    Container(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _makeitems('assets/images/music.jpg', 'Music'),
                          _makeitems('assets/images/dance.jpg', 'Dance'),
                          _makeitems('assets/images/writing.jpg', 'Writing'),
                          _makeitems('assets/images/acting.jpg', 'Acting'),

                        ],
                      ),
                    ),
                    Divider(height: 15.0,),
                    Text(
                      "Explore Current Events",
                      style: TextStyle(fontSize: 20.0,
                          fontFamily: 'Dancing',
                          fontWeight: FontWeight.bold),

                    ),
                    SizedBox(height: 8.0,),

                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _makeitems(
                              'assets/images/tournament.jpg', 'Tournamnets'),
                          _makeitems('assets/images/party.jpg', 'Party'),
                          _makeitems('assets/images/fest.jpg', 'Fest'),
                          _makeitems('assets/images/surprise.jpg', 'Surprise'),

                        ],
                      ),
                    ),
                    Divider(height: 15.0,),
                    Text(
                      "Explore Upcoming Events",
                      style: TextStyle(fontSize: 20.0,
                          fontFamily: 'Dancing',
                          fontWeight: FontWeight.bold),

                    ),
                    SizedBox(height: 8.0,),

                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _makeitems(
                              'assets/images/sports.jpg', ' Inter Sports'),
                          //_makeitems('assets/images/2.jpg'),
                          //_makeitems('assets/images/2.jpg'),
                          //_makeitems('assets/images/2.jpg'),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        splashColor: Colors.grey[200],
      ),
    );
  }

  AspectRatio buildHighlightContainer(String image) {
    return AspectRatio(
      aspectRatio: 4/3,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image(image: AssetImage(image),fit: BoxFit.fill,),
        )

      ),
    );
  }

  FlatButton _makeitems(String image, String text) {
    return FlatButton(
      splashColor: Colors.grey,
      onPressed: () {},
      child: AspectRatio(
        aspectRatio: 1/1,
        child: Container(
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              )
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),

              ),
            ),
          ),
        ),

      ),
    );
  }

  Container _buildBlurredList(BuildContext context, String image) {
    return null;
  }
}


