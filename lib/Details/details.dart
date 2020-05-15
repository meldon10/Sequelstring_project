import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:welcome_page/Details/detailspage.dart';
import 'package:welcome_page/confirm/confirmdetails.dart';
import 'package:welcome_page/main.dart';

TextEditingController time = new TextEditingController();
TextEditingController display = new TextEditingController();


var facultymeetingtime=[];  //list to store meeting time

var facultyselect,temp;

TextEditingController name =new TextEditingController(); // Controller for textfield

var facultytime= {}; 
var SelectedEmail="";
  var facultykeys=[];
  var facultyvalues=[];
        // Map to store the meeting time and facultyname
  
  class DateTimePickerExample extends StatefulWidget {
    @override
    DateTimePickerExampleState createState() {
      
      return DateTimePickerExampleState();
    }
  }
  

  class DateTimePickerExampleState extends State<DateTimePickerExample> {
  
DateTime date1;  
  
    // await for(var snapshot in Firestore.instance.collection('staff').snapshots()){
    // for(var message in snapshot.documents){
      
    //   if(message.data['name'] == SelectedFaculty){
    //     SelectedEmail = message.data['email'];
    //       break;
    //   }  
    // }

    // }


  @override
    Widget build(BuildContext context) => Scaffold(
       appBar: AppBar(
        title: const Text('DETAILS'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          
          children: <Widget>[

              // DropDown Button To Display Faculty Name

                new Column(
                  children: <Widget>[
                    new Container(
//                      child: new Text(
//                          "PERSON SELECTED : $SelectedFaculty",
//                        style: new TextStyle(
//                          fontSize: 18,
//                          fontWeight: FontWeight.w400,
//
//                        ),
//                      ),


                    ),
//                     new  DropdownButton<String>(
//
//                      items: facultylist.map((String dropDownStringItem){
//
//                      return DropdownMenuItem<String>(
//                      value: dropDownStringItem,
//                      child: Text(dropDownStringItem),
//
//
//                  );
//                 }).toList(),
//
//                  onChanged: (String newvalue){
//                        setState(() {
//                    facultyselect=newvalue;
//                    temp=newvalue;
//                    name.text=facultyselect==facultylist.elementAt(0)?"": facultyselect;
//                    });
//                 },
//
//                      //value:facultylist.elementAt(0),
//
//                        ),

                          new TextField(
                             controller: name,
                          ) ,

                          Padding(padding: EdgeInsets.only(bottom: 10.0),),

               DateTimePickerFormField(

                  controller: time,
                  inputType: InputType.both,
                  format:new DateFormat().add_yMd().add_jm(),
                  
                  //DateFormat("EEEE , dd-MM-yyyy 'at' h:mma"),
                  editable: false,
                  decoration: InputDecoration(
                      labelText: 'ENTER DATE AND TIME FOR MEETING',
                      hasFloatingPlaceholder: false
                           ),
              onChanged: (dt) {
                setState(() {
                 date1=dt; 
                date1==null?date1=dt:facultymeetingtime.add(date1);
        
                 });
           
              },
            ),

             Padding(padding: EdgeInsets.only(bottom: 10.60),),

//            new Container(
//              alignment: Alignment.bottomRight,
//              child:  new RaisedButton(
//              color: Colors.green,
//              onPressed: (){
//                facultytime.addAll({"${name.text}":"${time.text}"});
//                facultyselect==facultylist.elementAt(0)?facultyselect=temp:facultylist.remove(facultyselect);
//                facultykeys=facultytime.keys.toList();
//                facultyvalues=facultytime.values.toList();
//                name.clear();
//                time.clear();
//
//
//
//                 setState(() {
//
//                 });
//
//              },
//              child: new Text("SET TIME",style: new TextStyle(color: Colors.white),),
//            ),
//
//            ),

             Padding(padding: EdgeInsets.only(top: 30.60),),

            new Container(
              height: 200.0,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black),
                borderRadius: new BorderRadius.circular(7.0)
              ),
               child:date1==null?new Text("NO TIME SET", textAlign: TextAlign.center, style: new TextStyle(fontWeight:FontWeight.w500),):ListView.builder(
                 shrinkWrap: true,
                 itemCount: 1,
                 itemBuilder: (_,int index){
                   return  Card(
                     child: new  ListTile(
                       title:Text(SelectedFaculty),
                       subtitle: new Text("$date1"),


                     ),


                   );
                 },
               ),
//               new Text(
//                 "$SelectedFaculty : $date1"
//
//               ),


              //ListView.builder(
              //      shrinkWrap: true,
              //     itemCount: facultytime.length,
              //     reverse: false,
              //     itemBuilder: (_,int index){
              //       return Card(
              //        child: new ListTile(
              //           title: Text(facultykeys[index]),
              //           subtitle:Text(facultyvalues[index]),
              //           trailing: new IconButton(icon: new Icon(Icons.remove_circle), onPressed: (){
              //             setState(() {
              //              facultylist.add(facultykeys[index]);
              //              facultytime.remove(facultykeys[index]);
              //              facultykeys.removeAt(index); 
              //              facultyvalues.removeAt(index);
                           
              //             });
              //           },),
                         
              //             )
              //       );
              //     },
              //   )
        
            ),

             Padding(padding: EdgeInsets.only(bottom: 50.50),),
           
            new Container(
              alignment: Alignment.bottomRight,
              child : new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[


                   new RaisedButton(

                    color: Colors.green,
                    onPressed: (){

                      Navigator.push(context,new MaterialPageRoute(builder:(context)=>new Confirmation(
                        data: date1,
                      )));
                    },
                    child: new Text("NEXT",style:new TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ),
           
           

                   ],
                )
             
          ],
        ),
      )
    );
  }
  
 /* class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: DateTimePickerExample(),
      );
    }
  }
  
  Future<void> main() async {
    runApp(MyApp());
  }*/