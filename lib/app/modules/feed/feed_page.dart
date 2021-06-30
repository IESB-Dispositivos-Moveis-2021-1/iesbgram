import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key? key, this.title = 'FeedPage'}) : super(key: key);
  @override
  FeedPageState createState() => FeedPageState();
}
class FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iesbgram'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
