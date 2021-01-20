import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recycleviewdemo/conts.dart';

class RcDemo extends StatefulWidget {
  @override
  _RcDemoState createState() => _RcDemoState();
}

class _RcDemoState extends State<RcDemo> {
  var list = FOOD_DATA;
  List<Widget> itemsData = new List<Widget>();

  @override
  void initState() {
    super.initState();
    for (var ls in list) {
      itemsData.add(createelement(ls));
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  Widget createelement(var ls) {
    return Container(
      width: 20,
      child: Card(
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(ls['name']),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 2,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FlatButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          removelist(list.indexOf(ls));
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FlatButton(
                        color: Colors.amberAccent,
                        onPressed: () {
                          editlist(list.indexOf(ls), generateRandomString(5));
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  addnewlistlist(var index) {
    var ls = list[index];

    setState(() {
      itemsData.insert(index, createelement(ls));
    });
  }

  editlist(var id, var name) {
    setState(() {
      list[id]['name'] = name;
      itemsData[id] = createelement(list[id]);
    });
  }

  removelist(var id) {
    print(id);
    setState(() {
      list.removeAt(id);
      itemsData.removeAt(id);
    });
  }

  var message = "";
  @override
  Widget build(BuildContext context) {
    ScrollController controllerA = ScrollController();
    controllerA.addListener(() {
      if (controllerA.offset >= controllerA.position.maxScrollExtent &&
          !controllerA.position.outOfRange) {
        setState(() {
          list.add({"name": "krButani", "id": (list.length + 1)});
          addnewlistlist(list.length - 1);
          message = "reach the bottom";
        });
      }
      if (controllerA.offset <= controllerA.position.minScrollExtent &&
          !controllerA.position.outOfRange) {
        setState(() {
          message = "reach the top";
        });
      }
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Recycle View'),
        ),
        body: Column(
          children: [
            Text(message),
            /* Expanded(
                child: GridView.count(
                    
                    crossAxisCount: 2, children: itemsData.toList())), */
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: controllerA,
                  itemCount: itemsData.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return itemsData[index];
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              list.insert(0, {"name": "krButani", "id": (list.length + 1)});
              addnewlistlist(0);
            });
          },
          child: Text("+"),
        ),
      ),
    );
  }
}
