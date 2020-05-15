import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:welcome_page/Details/detailspage.dart';
import 'package:welcome_page/Details/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Details/details.dart';
import '../Details/detailspage.dart';
import '../main.dart';
import 'package:welcome_page/main.dart';

var facultyPhone;
/*void main() {
  runApp(
    new MaterialApp(
      title: "Confirmation Page",
      home: new Confirmation(),
    )
  );
}
*/

var Dno;
class Confirmation extends StatefulWidget{
  final DateTime data;
  Confirmation({this.data});
  @override
  State<StatefulWidget> createState() {
    return new Confirm(
      date11: data,
    );
  }
}

class Confirm extends State<Confirmation>{

final DateTime date11;
Confirm({this.date11});
  var name=username.text;
  var temail=email.text;
  var mob1=mobile.text;


   addUser() {
     Firestore.instance.collection('staff').getDocuments().then((val)
     {
       var lengthDB = val.documents.length;
       for(var i=0;i<lengthDB;i++){
         if(val.documents[i].data['email'] == SelectedEmail){
           Dno= val.documents[i].documentID;
           facultyPhone = val.documents[i].data['phone'];
          // print(facultyPhone);9
           print(Dno);
           Firestore.instance.collection('staff').document(Dno).collection('Visitors').add({
             'Date': date11.toString(),
             'contact': phone,
             'email': temail,
             'name': name,
             'Location': "Mumbai",
             'image': uploadedFileUrl,
             'status': 0

           }).then((documentRefernece){
             print(documentRefernece.documentID);

           }).catchError((e){
             print(e);
           });
           break;
         }
       }
     });
//     print(Dno);
//     Firestore.instance.collection('staff').document(Dno).collection('Visitors').add({
//      'Date': date11,
//      'contact': phone,
//       'email': temail,
//       'name': name,
//      'Location': "Mumbai",
//      'status': 0
//
//    }).then((documentRefernece){
//      print(documentRefernece.documentID);
//
//    }).catchError((e){
//      print(e);
//    });
  }

  ReadUser() {
    Firestore.instance.collection('staff').getDocuments().then((val){
      var dblen = val.documents.length;
      for(var i=0;i<dblen;i++){
        if(val.documents[i].data['name']==SelectedFaculty){
          SelectedEmail = val.documents[i].data['email'];
          print(SelectedEmail);
          break;
        }
      }
    });
   }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CONFIRM DETAILS"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(10.0),
        child:
        new ListView(
            children: <Widget>[
              
              Padding(padding: EdgeInsets.only(top: 5.0),),

              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
              new Container(
              
              child:   imagepic==null ?Container(
                
                      height: 120.0,
                      width: 120.0,
                      padding: EdgeInsets.only(top: 45.0,left: 3.0),
                      child:Text("NO IMAGE",textDirection: TextDirection.ltr,textAlign: TextAlign.center,),
                      decoration: new BoxDecoration(
                      border:new Border.all(color: Colors.black ,width: 1.5),
                       
                    ),):Image.file(imagepic ,height:150.0, width:150.0,),
              
              ),
               Padding(padding: EdgeInsets.only(top: 5.0),),
              new Container(
                height: 1.5,
                color: Colors.black,
              ),

               Padding(padding: EdgeInsets.only(top: 5.0),),
                  
              new TextField(controller: username,
                enabled: false,
                 decoration: InputDecoration(
                  hintText: "NAME",
                  icon: new Icon(Icons.person),
                  ),
                    ),

            Padding(padding:EdgeInsets.only(top:5.0)),   
           
            new TextField(controller: email,
            decoration: InputDecoration(
              enabled: false,
              hintText: "EMAIL",
              icon: new Icon(Icons.email),
            ),
            ),

             Padding(padding:EdgeInsets.only(top:5.0)),  

             new TextField(controller: mobile,
              enabled: false,
              decoration: InputDecoration(
              hintText: "CONTACT NO",
              icon: new Icon(Icons.phone),
            ),

            ),
            Padding(padding:EdgeInsets.only(top:10.0)),
            new Text("FACULTY TO MEET",textDirection: TextDirection.ltr,style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500),),
            Padding(padding:EdgeInsets.only(top:10.0)),  
            new Container(
              height: 150.0,
              padding: EdgeInsets.only(top: 25.0),
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black),
                borderRadius: new BorderRadius.circular(7.0), 
                
              ),
//              child: new Text(
//                "Faculty : $SelectedFaculty \nTime :$date11  "
//              ),
                child: date11==null?new Text("No Person Selected", textAlign: TextAlign.center, style: new TextStyle(fontWeight:FontWeight.w500),):ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (_,int index){
                    return  Card(
                      child: new  ListTile(
                        title:Text(SelectedFaculty),
                        subtitle: new Text("$date11"),


                      ),


                    );
                  },
                ),
          
            ),

                new Container(
                padding: EdgeInsets.only(top: 7.0,right: 12.0),
               alignment: Alignment.bottomRight,
               child: new RaisedButton(
                 color: Colors.green,
                 onPressed: () {
                    ReadUser();
                    addUser();

                    // ADD NOTIFICATION FOR FACULTY


                    sendConfirm();
                    sendFacultyMessage();
                    //mobile.clear();
                    otp.clear();
                    mob.clear();
                    time.clear();

                    Navigator.popUntil(context,ModalRoute.withName('/'));

                 },
                 child: new Text("CONFIRM", style: new TextStyle(color: Colors.white),),
                 
                   )
          
                                 )

                ],
              ),
              ],
        ),
        ),
      
      
    );
  }


}