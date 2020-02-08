import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 20),
              //We can remove left and right just leaving in case we need them to save time
              child: Text("Small profile summary fjgdgfkgdhf "
                  "fgofdgoif fgoihdofg"),
            ),
            Container(
              height: 200,
              child: GridView.count(
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(6, (index) {
                  print(index);
                  return Center(
                    child: Text(
                      'Skill $index',
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                    ),
                  );
                }),
              ),
            ),
            Container(
              child: FlatButton.icon(
                color: Colors.blueGrey,
                icon: Icon(Icons.edit), //`Icon` to display
                label: Text('Edit Skills'), //`Text` to display
                onPressed: () {
                  List<Widget> skillsList = [];
                  Future<String> getData() async {
                    http.Response response = await http.get(
                      Uri.encodeFull("http://167.172.59.89:5000/postskills"),
                      headers: {"Accept": "application/json"},
                    );


                    List data = json.decode(response.body);
                    var counter = 0;
                    print(response.body);
                    while (counter < data.length) {
                      int id = data[counter]["id"];
                      String name = data[counter]["name"];
                      String description = data[counter]["description"];
                      var aButton = new FlatButton(onPressed: null,
                          child: Text(
                              name)); //TODO: Add send message to backend to add skill on click
                      skillsList.add(aButton);

                      counter++;
                    }
                  }
                  getData();
                  returnSkillButtons() {
                    return skillsList;
                  }
              showDialog(context: context,
              builder: (BuildContext context) {


                  return AlertDialog(
                    //Put list of skill buttons here
                    title: Text("Add skills"),
                    content: Column(
                        children: returnSkillButtons() //Can probably remove the method and directly put the list done jsut for testing

                    ),
                  );
                  });
                },
              ),
            ),
            Container(
              child: Card(
                margin: EdgeInsets.fromLTRB(7, 4, 7, 4),
                color: Colors.blueGrey,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: new Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Card(
                margin: EdgeInsets.fromLTRB(7, 0, 7, 10),
                color: Colors.blueGrey,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    onPressed: () {
                      String email, password;

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: "email address"),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          onSaved: (String val) {
                                            email = val;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: RaisedButton(
                                          child: Text("Submit"),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();

                                              var url =
                                                  'http://167.172.59.89:5000/deleteaccount';

                                              http.put(url, body: {
                                                'email': email,
                                              });
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                  '/login');
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: new Text(
                      'Delete the account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
