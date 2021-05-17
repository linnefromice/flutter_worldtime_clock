import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MaterialButton(
                padding: EdgeInsets.all(16.0),
                color: Colors.pink,
                shape: CircleBorder(),
                child: Icon(Icons.add),
                onPressed: () {},
              )
            ],
          ),
          Container(
            child: Column(
              children: [
                Text("ClockContainer"),
                SizedBox(height: 20.0),
                Text(
                  "Asia/Japan",
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                  )
                ),
                Text(
                  "21:00",
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}