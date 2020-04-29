import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Center(child:ExampleGrid()),
  ),
);

class ExampleGrid extends StatefulWidget {
  @override
  State createState() => new _MyHomeState();
}
class _MyHomeState extends State<ExampleGrid> {
  bool selected = false;
  List<int> selectedArr = new List.filled(9, 0);
  bool playerOne = true;
  List<int> rows = new List.filled(3, 0);
  List<int> cols = new List.filled(3, 0);
  int diagonal = 0;
  int antidiagonal = 0;
  Set<int> visited = new Set();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child:CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10.0,
                crossAxisCount: 3,
                children: (List.generate(9, (index) {
                  return new GestureDetector(onTap:(){
                    setState((){
                      if(visited.contains(index)){
                        return;
                      }
                      visited.add(index);
                      int c = index%3;
                      int r = (index~/3);
                      if(playerOne){
                        selectedArr[index] = 1;
                        playerOne = false;
                        rows[c]++;
                        cols[r]++;
                        if(r==c){
                          diagonal++;
                        }
                        if(r+c==2){
                          antidiagonal++;
                        }
                        if(rows[c]==3||cols[r]==3||diagonal==3||antidiagonal==3){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("We have a winner"),
                                content: new Text("Player 1 won"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }else{
                        selectedArr[index] = 2;
                        playerOne = true;
                        rows[c]--;
                        cols[r]--;
                        if(r==c){
                          diagonal--;
                        }
                        if(r+c==2){
                          antidiagonal--;
                        }
                        if(rows[c]==-3||cols[r]==-3||diagonal==-3||antidiagonal==-3){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("We have a winner"),
                                content: new Text("Player 2 won"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    });
                  },
//                      child:Card(child: Image.network("https://robohash.org/$index")));
                      child: Card(child: selectedArr[index]==0?new Image.asset('images/blank.png'):selectedArr[index]==1?new Image.asset('images/cross.png'):new Image.asset('images/0.jpg')));
                })),
              ),
            ),
          ],
        ))
    );
  }

}

void _showDialog() {
  // flutter defined function

}