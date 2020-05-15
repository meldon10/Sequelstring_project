import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:welcome_page/main.dart';
import 'package:welcome_page/fetchnew2.dart';
import 'package:welcome_page/staff/staffpage.dart';
import 'package:welcome_page/staff/staff.dart';

var checkvisitor;
var current2,SelectedEmail;



class FacultyLog2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new crudmethods2();
  }
}


class crudmethods2 extends State<FacultyLog2>{


  //QuerySnapshot querySnapshot;
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: new Text("STAFF PAGE"),
          backgroundColor: Colors.green,
//          leading: IconButton(
//            icon: new Ico,
//              onPressed: (){
//                print("IconFace");
//              }
//
////          ),
//          title: Container(
//            alignment: Alignment.center,
//            child: Text("STAFF",style: TextStyle()),
//
//          ),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(
//                Icons.favorite,
//                color: Colors.white,
//                size: 20.0,
//              ),
//              onPressed: null,
//            )
//          ],
        ),
        body: StreamBuilder(


          stream: Firestore.instance.collection('staff').document(userDocument).collection('Visitors').snapshots(),
          builder:(context,snapshot) {
            //var temp = snapshot.data.documents.length;

            try{
              if(!snapshot.hasData){
                print(userDocument);
                return const Text('loading');
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,


                    itemBuilder: (context,index){


                      DocumentSnapshot mypost = snapshot.data.documents[index];
                      if(mypost['status']==1) {
                        return new Card(
                          child: ListTile(
                            leading: new Icon(Icons.person, color: Colors.green,),
                            onTap: () {
                              current2 = mypost;
                              Navigator.push(context, new MaterialPageRoute(
                                builder: (context) => new Try12(),
                              ),
                              );
                            },
                            title: new Text('${mypost['name']}'),
                            subtitle: new Text('${mypost['email']}'),


                          ),


                        );
                      }
                      else{
                        return new Container();
                        print("Else Part");
                      }
                    }

                );
              }
            }catch(err){
              return const Text('loading');
            }
          },
        )

    );
  }


}