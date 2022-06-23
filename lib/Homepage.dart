import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled5/Description.dart';
import 'package:untitled5/Person.dart';
import 'package:untitled5/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  class homepage extends StatefulWidget {
    @override
    _homepageState createState() => _homepageState();
  }

  class _homepageState extends State<homepage> {
    String datatoshow = "kitchen";
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    Color color1 = Colors.grey;
    User? loggedin;
    @override
    void initState(){
      getuser();
      super.initState();
    }
    void getuser() async{
      final user = await _auth.currentUser;
      if(user != null){
        loggedin = user;
        print(loggedin?.email);
      }
    }

    static const List<String> opt = ["kitchen", "dairy", "Household", "Personal care", "Snacks", "Stapes"];
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => cart()),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profile()),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                  height: MediaQuery.of(context).size.height/5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ClipRect(
                    child:Image.asset('assets/images/ad.jpg'),
                  )
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 30,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: opt.map((country){
                    return Container(
                      color: Colors.white,
                      height: 300,
                      width:140,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            datatoshow = country;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)
                              )
                          ),
                        ),
                        child: Text(country,style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 30,
              ),



              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('$datatoshow').snapshots(),
                builder: (context,snapshot) {
                  final items = snapshot.requireData.docs;
                  final List<Container> storeit = [];
                  if(snapshot.hasData){
                    for(var i in items){
                      final String itemname = i.get('Name');
                      final String itemprice = i.get('Price');
                      final String itemquantity = i.get('Quantity');
                      final String itemlikes = i.get('Likes');
                      final String itemimage = i.get('Image');
                      final String itemdescription = i.get('Description');
                      final user = _auth.currentUser;
                      String authuser = " ";
                      if(user != null){
                        authuser = user.email!;
                      }
                      final widg = Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                //container-----------------------------
                                Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => description(itemname,itemdescription,itemlikes,itemprice,itemimage,authuser,itemquantity)),
                                        );
                                      },
                                      child: Row(
                                          children: <Widget>[
                                            Image.asset("assets/images/$itemimage.jpg",
                                                width: 80,
                                                height: 80,
                                                fit:BoxFit.fill
                                            ),
                                            Text("$itemname",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                                            Row(
                                              children: <Widget>[
                                                Text("₹"+(int.parse(itemprice)*2-(int.parse(itemprice)/2)).toString(),style: TextStyle(fontSize: 8,color: Colors.red,decoration: TextDecoration.lineThrough),),
                                                Text("₹$itemprice",style: TextStyle(fontSize: 7,color: Colors.green),),
                                                IconButton(
                                                  icon: Icon(Icons.favorite,color: color1,),
                                                  onPressed: () {
                                                    setState(() {
                                                      if(color1 == Colors.grey){
                                                        _firestore.collection('$datatoshow').where('Name', isEqualTo: itemname).get().then((querySnapshot) {
                                                          querySnapshot.docs.forEach((documentSnapshot) {
                                                            documentSnapshot.reference.update({
                                                              'Likes': (int.parse(itemlikes)+1).toString()
                                                            });
                                                          });
                                                        });
                                                        color1 = Colors.pinkAccent;
                                                      }
                                                      else{
                                                        _firestore.collection('$datatoshow').where('Name', isEqualTo: itemname).get().then((querySnapshot) {
                                                          querySnapshot.docs.forEach((documentSnapshot) {
                                                            documentSnapshot.reference.update({
                                                              'Likes': (int.parse(itemlikes)-1).toString()
                                                            });
                                                          });
                                                        });
                                                        color1 = Colors.grey;
                                                      }
                                                    });
                                                  },
                                                )
                                              ],
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      );
                      storeit.add(widg);
                    }
                  }
                  return Expanded(
                      child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                      children: storeit
                  )
                  ),
                  );
                },
              ),
            ]
          ),
        ),
      );
    }
  }

