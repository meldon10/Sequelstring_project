import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:welcome_page/Details/details.dart';
import 'dart:io';
import 'package:welcome_page/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;


// MAIN FACULTY LIST
//var faculty=["Select Faculty To Meet","Amiya Tripathy","Sejal Chopra","Imran Mirza","Firoz Khan","Shanila Mula","Ditty Vargaresh","Priya Kaul"];
final dbRef = Firestore.instance;
//var faculty = ['abcd'];
var imageid = 0;
List<DropdownMenuItem> faculty = [];
var uname = name.text;
var stt = [];
final FirebaseStorage _storage = FirebaseStorage(storageBucket:'gs://phoneauth-10d2e.appspot.com/');
 StorageUploadTask uploadTask;
var currentvalue ="";
var removevalue="";
File imagepic,idpic;


var i=0,f;
var  uploadedFileUrl ;
var SelectedFaculty;

TextEditingController username = new TextEditingController();
TextEditingController email = new TextEditingController();

TextEditingController mobile = new TextEditingController();

var facultydisplay=[];
var facultylist=[];


void previously_visited(){
  Firestore.instance.collection('visitor').getDocuments().then((val){
    var dblen = val.documents.length;
    for(var i=0;i<dblen;i++){
      if(val.documents[i].data['contact']==temp3){
        username.value= username.value.copyWith(text:val.documents[i].data['name'] );
        email.value= email.value.copyWith(text:val.documents[i].data['email'] );

        break;
      }
    }
  });
}






/*void main()
{
  runApp(
    new MaterialApp(
      title:"DETAILS PAGE0",
      home: new Details(),
    )
  );
}*/

class Details extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    mobile.value=mobile.value.copyWith(text: temp3);
    return new Detailspage();
  }
}



class Detailspage extends State<Details>{
  Map dropDownItemsMap;


  List<DocumentSnapshot> _queryCat;

  var _category;

  bool dropDown = true;


  void copydata(bool value){
    setState(() {
      if (value==true){
        facultylist.add(currentvalue);
      }
      else{
        facultylist.remove(removevalue);
      }
    });

  }

  Future getimage () async {

    File image1;
    imageid++;
    image1 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imagepic = image1;

    });
  }


  Future getIdpic () async{
    File image2;
    image2 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      idpic=image2;
    });

  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        
        title:new Text("DETAILS PAGE",),
        backgroundColor: Colors.green,
      ),
    body: 
        Padding(
          padding: EdgeInsets.all(10.0),
          child:   new ListView(

      
          children: <Widget>[
            
            new Column(
              children: <Widget>[
            
            new TextField(controller: username,
            decoration: InputDecoration(
              hintText: "NAME",
              icon: new Icon(Icons.person),
            ),
            ),

            Padding(padding:EdgeInsets.only(top:15.0)),   
           
            new TextField(controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "EMAIL",
              icon: new Icon(Icons.email),
            ),
            ),

             Padding(padding:EdgeInsets.only(top:15.0)),  

             new TextField(controller: mobile,
            
              decoration: InputDecoration(
              hintText: "CONTACT NO",
              icon: new Icon(Icons.phone),
            ),

            
            ),

             Padding(padding: EdgeInsets.only(top: 15.0),),
            new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//                  children: <Widget>[

                    children: <Widget>[
                      imagepic==null ?Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 110.0,
                        width: 110.0,
                        padding: EdgeInsets.only(top: 35.0),
                        child:Text("NO VISITOR IMAGE UPLOADED",textDirection: TextDirection.ltr ,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.w500),),
                        decoration: new BoxDecoration(
                            border:new Border.all(width:1.0),
                            borderRadius: new BorderRadius.circular(7.0)

                        ),):Image.file(imagepic ,height:135.0, width:115.0,),

                      Padding(padding: EdgeInsets.only(top:5.0),),
                      new RaisedButton(

                        child: Text("TAKE A PICTURE",style: TextStyle(color: Colors.white),),
                        color: Colors.lightGreen,
                        onPressed:getimage,
                      ),

                    ],

            ),
          Padding(padding: EdgeInsets.only(bottom: 15.0),),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              idpic==null ?Container(
                margin: EdgeInsets.only(left: 10.0),
                height: 110.0,
                width: 110.0,
                padding: EdgeInsets.only(top: 35.0),
                child:Text("NO ID IMAGE UPLOADED",textDirection: TextDirection.ltr ,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.w500),),
                decoration: new BoxDecoration(
                    border:new Border.all(width:1.0),
                    borderRadius: new BorderRadius.circular(7.0)

                ),):Image.file(idpic ,height:135.0, width:115.0,),

              Padding(padding: EdgeInsets.only(top:5.0),),
              new RaisedButton(

                child: Text("TAKE A PICTURE",style: TextStyle(color: Colors.white),),
                color: Colors.lightGreen,
                onPressed:getIdpic,
              ),

            ],
          ),

//
//
//                    imagepic==null ?Container(
//                      margin: EdgeInsets.only(left: 10.0),
//                      height: 110.0,
//                      width: 110.0,
//                      padding: EdgeInsets.only(top: 45.0),
//                      child:Text("NO IMAGE",textDirection: TextDirection.ltr ,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.w500),),
//                      decoration: new BoxDecoration(
//                      border:new Border.all(width:1.0),
//                      borderRadius: new BorderRadius.circular(7.0)
//
//                    ),):Image.file(imagepic ,height:135.0, width:115.0,),
//
//                   Padding(padding: EdgeInsets.only(top:5.0),),
//                    new RaisedButton (
//
//                   child: Text("TAKE A PICTURE",style: TextStyle(color: Colors.white),),
//                   color: Colors.lightGreen,
//                   onPressed:getimage
//                    ),
//
//                   ],




                  new Container(
          
             alignment: Alignment.center,
              
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
              new StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('staff').snapshots(),
                      builder: (context, snapshot){
                        if (!snapshot.hasData) {
                          return new
                          Text("Loading");
                        }
                        else{
                          faculty = [];
                          for(var i=0 ;i<snapshot.data.documents.length;i++)
                            {
                              DocumentSnapshot ds = snapshot.data.documents[i];
                              //print(ds.data['name']);
                              //print(faculty);
                              faculty.add(
                                new DropdownMenuItem(
                                  child: new Text(ds.data['name'],
                                  style: TextStyle(
                                  ),),
                                  value: ds.data['name'],
                              ),
                              );
                            }
                          return new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.person),
                              DropdownButton(
                                items: faculty,
                                onChanged: (newValue){
                                 print("Item added $currentvalue");
                                  //print(faculty);
                                  setState(() {
                                    currentvalue = newValue;

                                   if(facultydisplay.isEmpty){
                                    print("First value");
                                    facultydisplay.add(currentvalue);
                                    SelectedFaculty = currentvalue;
                                    name.text=SelectedFaculty;
                                    //copydata(true);
                                  }
                                   else{
                                      Fluttertoast.showToast(msg: "You can't add more than one !!",
                                     toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER);
                                   }
                                  print(facultydisplay);
                                  });
                                },
                               // value: currentvalue.toString(),
                                isExpanded: false,
                                hint: new Text(
                                  "SELECT PERSON TO MEET"
                                ),
                              )
                            ],
                          );
                        }
  }
                  ),


                 ],
           )
              ),

              new Container(
                alignment: Alignment.center,
                height: 160.0,
                decoration: new BoxDecoration(
                  border: new Border.all(width: 1.0),
                  borderRadius: new BorderRadius.circular(7.0),
              
                  
                ),
                child: facultydisplay.isEmpty?new Text("NO SELECTION DONE",style: new TextStyle(fontWeight: FontWeight.w500),): ListView.builder(
                    shrinkWrap: true,          
                       itemCount: facultydisplay.length,
                       itemBuilder: (_,int index){
                         return  Card(
                        child: new  ListTile(
                          title:Text(facultydisplay[index]),
                          trailing: IconButton(icon: new Icon(Icons.remove_circle) ,onPressed:(){
                            setState(() {
                                debugPrint("DELETED");
                                removevalue=facultydisplay[index];
                                facultydisplay.removeAt(index);  
                                copydata(false); 
                                    });
                   
                                      } ,),
                                
                              ),
                              
                            
                            );
                       },
                     ),
                

              ),
              
              new Container(
              alignment: Alignment.bottomRight,
              child:
               new RaisedButton(
                
                 onPressed: ()async{
                   uploadFile();
                  AddVisitor();
                   Navigator.push(context,new MaterialPageRoute(builder: (context)=>new DateTimePickerExample()));
                 },
                 
                  child:Text("NEXT",style: new TextStyle(color: Colors.white),),
                  color: Colors.green,
             
            )
           

            )
           ],
            )



        
        ]
            ),

        )
          
    );
    
  }
   uploadFile() async{
   
    String filepath = 'images/${DateTime.now()}.png';
    setState(() {
     uploadTask = _storage.ref().child(filepath).putFile(imagepic);
    });
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
       final String url = await taskSnapshot.ref.getDownloadURL();
       print(url);
       setState(() {
         uploadedFileUrl = url;
       });
  //     final String filename = Random().nextInt(1000).toString()+'.jpg';
  //   StorageReference storageReference =FirebaseStorage.instance
  //   .ref().child(filename);
 

  //   StorageUploadTask uploadTask = storageReference.putFile(imagepic);
   
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   final String url = await taskSnapshot.ref.getDownloadURL();
  //  print(url);
  //   _uploadedFileUrl = url;

  }

  AddVisitor(){
    print(uploadedFileUrl);
    Firestore.instance.collection('visitor').add({
      'name': username.text,
      'email': email.text,
      'contact': phone,
      'image': uploadedFileUrl
  }).then((documentRefernece){
      print(documentRefernece.documentID);

    }).catchError((e){
      print(e);
    });

  }

}

