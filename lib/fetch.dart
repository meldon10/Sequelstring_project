import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:welcome_page/main.dart';
import 'package:welcome_page/fetchnew.dart';
import 'package:welcome_page/staff/staffpage.dart';

var checkvisitor;
var current;



class FacultyLog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new crudmethods();
  }
}


class crudmethods extends State<FacultyLog>{



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
                     if(mypost['status']==0) {
                       return new Card(
                         child: ListTile(
                           leading: new Icon(Icons.person, color: Colors.green,),
                           onTap: () {
                             current = mypost;
                             Navigator.push(context, new MaterialPageRoute(
                               builder: (context) => new Try11(),
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