

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/UI/game_page.dart';
import 'package:tic_tac_toe/UI/home_presenter.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}):super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
  
}
  
class _HomePageState extends State<HomePage> {

  HomePresenter _presenter;

  _HomePageState() {
    _presenter = HomePresenter();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Zagraj w XO :)"),
            Center(
              child: ButtonTheme(
                minWidth: 200,
                height: 80,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.amber, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  color: Colors.amber,
                  child: Text("Nowa gra", style: TextStyle(fontSize: 20),),
                  onPressed: (){ Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => GamePage(widget.title)
                    ));
                  },
              ),
              ),
            ), 
            StreamBuilder(
              stream: _presenter.buildVictorsStream(),
              builder: (context, snapshot){
                var playerCount = _presenter.getVictoryCountFromStream(snapshot);
                if(playerCount <= 0)
                  return Text("Komputer jeszcze nie wygrał", style: TextStyle(fontSize: 15),);

                return Text("Komputer wygrał: $playerCount", style: TextStyle(fontSize: 15),);
              }
            )
          ],
        ),
      );
  }
}