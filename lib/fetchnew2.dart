import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:welcome_page/fetch.dart';
import 'package:welcome_page/main.dart';
import 'package:welcome_page/staff/newTime.dart';
import 'package:welcome_page/fetch_Past.dart';

DocumentSnapshot mypost;
TextEditingController nameVisitor =new TextEditingController();
var CurrentFaculty1;
var tempSnap1;
var phoneNo1;
class Try12 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new crudmethods2();
  }
}


class crudmethods2 extends State<Try12>{




  //QuerySnapshot querySnapshot;
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: new  Text("VISITOR DETAILS",style: TextStyle()),

        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('staff').document(userDocument).collection('Visitors').snapshots(),
          builder:(context,snapshot){
            if(!snapshot.hasData){
              return const Text('loading Please Ensure You Have Active Internet Connection');
            }
            else{
//              tempSnap = Firestore.instance.collection('staff').document(userDocument).snapshots();
//              print(tempSnap['name']);
//              var CurrentFaculty = tempSnap.data['name'];
//              print(CurrentFaculty);
              mypost = current2;
              print("$mypost");
              phoneNo1 = '${mypost['contact']}';
              nameVisitor.text='${mypost['name']}';
              debugPrint("$phoneNo1");
              return Stack(
                children: <Widget>[
                  Column(children: <Widget>[

                    Container(

                      width: MediaQuery.of(context).size.width,
                      height: 510.0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                        child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          shadowColor: Color(0x802196F3),
                          child: Center(child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Column(children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 220.0,
                                child: Image.network(
                                    '${mypost['image']}',
                                    fit : BoxFit.fill
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Name : ${mypost['name']}',
                                style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.bold),
                              ),

                              SizedBox(height: 10.0),
                              Text(
                                'Email : ${mypost['email']}',

                                style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.bold),
                              ),



                              SizedBox(height: 10.0),
                              Text(
                                'Phone : ${mypost['contact']}',
                                style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.bold),
                              ),

                              SizedBox(height: 10.0),
                              Text(
                                'City : ${mypost['Location']}',
                                style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.bold),
                              ),


                              SizedBox(height: 10.0),
                              Text(
                                'Time : ${mypost['Date']}',
                                style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.bold),
                              ),

                              SizedBox(height: 15.0),
//                              new Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: <Widget>[
//                                  new RaisedButton(onPressed:() {
//                                    Navigator.pop(context,ModalRoute.withName('/'));
//                                    sendAccept();
//                                  },
//                                    color: Colors.green,
//                                    child: new Text("ACCEPT",style: new TextStyle(color: Colors.white)),
//
//                                  ),
//                                  new RaisedButton(onPressed:(){
//
//                                    Navigator.push(context, new MaterialPageRoute(builder: (context)=>new newTime()));
//                                  },
//                                    color: Colors.green,
//                                    child: new Text("SET NEW TIME",style: new TextStyle(color: Colors.white)),
//
//                                  ),
//
//                                ],
//                              )
                            ],),
                          ),),
                        ),
                      ),
                    ),

                  ],),

//                  Container(
//
//                    alignment: Alignment.topLeft,
//                    padding: EdgeInsets.only(
//
//                      top: MediaQuery.of(context).size.height *.47,
//
//                    ),
//                    child: Container(
//                      width: MediaQuery.of(context).size.width,
//                      child: new RaisedButton(
//                        color: Colors.green,
//                        child: new Text("ACCEPT",style: new TextStyle(fontSize: 20,color: Colors.white),),
//                        onPressed: null,
//                      ),
//                    ),
//                  ),
//
//
//                  Container(
//
//                    alignment: Alignment.center,
//                    padding: EdgeInsets.only(
//                      //left: MediaQuery.of(context).size.height *.52,
//                      top: MediaQuery.of(context).size.height *.30,
//
//                    ),
//                    child: Container(
//                      width: MediaQuery.of(context).size.width,
//                      child: new RaisedButton(
//                        color: Colors.green,
//                        child: new Text("REJECT",style: new TextStyle(fontSize: 20,color: Colors.white),),
//                        onPressed: null,
//                      ),
//                    ),
//                  ),

//                  Container(
//
//                    alignment: Alignment.centerRight,
//                    padding: EdgeInsets.only(
//                      // left: MediaQuery.of(context).size.height *.52,
//                      top: MediaQuery.of(context).size.height *.46,
//
//                    ),
//                    child: Container(
//                      width: MediaQuery.of(context).size.width,
//                      child: new RaisedButton(
//                        color: Colors.green,
//                        child: new Text("SET NEW TIME",style: new TextStyle(fontSize: 20,color: Colors.white),),
//                        onPressed: null,
//                      ),
//                    ),
//                  )

                ],
                //itemCount: snapshot.data.documents.length;
              );






            }
          },





        )




    );
  }


}
