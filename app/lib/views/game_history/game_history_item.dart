import 'package:flutter/material.dart';
import 'package:sphinx/models/game.dart';
import 'package:sphinx/requests/DeleteGame.dart';
import 'package:http/http.dart' as http;

class GameHistoryItem extends StatefulWidget {
  final Game game;
  final int index;

  const GameHistoryItem({Key key, this.game, this.index}) : super(key: key);

  @override
  _GameHistoryItemState createState() => _GameHistoryItemState();
}

class _GameHistoryItemState extends State<GameHistoryItem> {

  bool loading = false;

  void deleteItem() async {
    setState(() {
      this.loading = true;
    });

    http.Response response = await DeleteGame(this.widget.game).send();
    
    setState(() {
      this.loading = false;
    });

    Navigator.of(context).pushNamed("/games");
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerColor: Theme.of(context).primaryColor,
        accentColor: Theme.of(context).primaryColor
      ),
      child: ExpansionTile(
        title: Text("Game #${this.widget.game.id}"),
        children: [
          this.categories(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                this.points(context),
                this.delete(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget categories(BuildContext context) {
    List<Chip> chips = List.generate(
      this.widget.game.categories.length, 
      (index) => Chip(
        backgroundColor: Theme.of(context).accentColor,
        label: Text(this.widget.game.categories[index].title)
      )
    );

    return Wrap(
      children: chips,
      spacing: 5.0,
      alignment: WrapAlignment.center,
    );
  }

  Widget points(BuildContext context) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Container(
        height: 60.0,
        child: Center(
          child: Text(
            "${this.widget.game.points} points earned",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          )
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(120.0)),
        ),
      )
    );
  }

  Widget delete(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(200.0))
        ),
        child: IconButton(
          icon: !this.loading ? Icon(Icons.delete, color: Colors.white) : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)),
          onPressed: () => {
            if (!this.loading) this.deleteItem()
          }
        ),
      )
    );
  }
}