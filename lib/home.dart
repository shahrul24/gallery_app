import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'add_image.dart';
import 'package:gallery_app/auth.dart';
import 'package:provider/provider.dart';
import 'package:gallery_app/blocs/theme.dart';
import 'package:gallery_app/themeoption.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[

      IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(
            builder: (c) => Auth()));
      },
    ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(
                    context).push (MaterialPageRoute(
                    builder: (context) => ThemeOption()));
              },
            )
    ],
          title: Text('Gallery'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddImage()));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container(
            padding: EdgeInsets.all(4),
            child: GridView.builder(
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(3),
                    child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: snapshot.data.docs[index].get('url')),
                  );
                }),
          );
        },
      ),
    );
  }
}