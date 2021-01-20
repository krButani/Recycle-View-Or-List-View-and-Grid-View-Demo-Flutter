# Recycle Or Listview And GridView Demo in flutter


### Create List Array 

```
var FOOD_DATA = [
  {"id": 1, "name": "Rajesh"},
  {"id": 2, "name": "Kartik"},
  {"id": 3, "name": "Mandeep"},
  {"id": 4, "name": "Jay Deep"},
  {"id": 5, "name": "Shiv"},
  {"id": 6, "name": "Ravi"},
  {"id": 7, "name": "Amir"},
  {"id": 8, "name": "Neel"},
  {"id": 9, "name": "Rahul"},
  {"id": 10, "name": "Salman"},
  {"id": 11, "name": "Akki"}
];

```

### Create Widget Array 

```

var list = FOOD_DATA;
List<Widget> itemsData = new List<Widget>();

for (var ls in list) {
    itemsData.add(createelement(ls));
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

```


### Create Scrollbar Controller

* it is also idetify Reach of scroll list view.

```
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
```

### Create List View

```
ListView.builder(
    shrinkWrap: true,
    controller: controllerA, // Assign Controller
    itemCount: itemsData.length,
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
    return itemsData[index];
}),
```
