import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:welcome_page/fetchnew.dart';
import 'package:welcome_page/main.dart';

TextEditingController newTimeSet = new TextEditingController();
var newtimevalue;

class newTime extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new Time();
  }

}

class Time extends State<newTime>{
  @override
  Widget build(BuildContext context) {

    return new Scaffold(

        appBar: AppBar(
          title: const Text("NEW DATE AND TIME"),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(

            children: <Widget>[

              // DropDown Button To Display Faculty Name

              new Column(
                children: <Widget>[
                  new TextField(

                    controller: nameVisitor,
                    enabled: false,


                  ) ,

                  Padding(padding: EdgeInsets.only(bottom: 30.0),),

                  DateTimePickerFormField(

                    controller: newTimeSet,
                    inputType: InputType.both,
                    format:new DateFormat().add_yMd().add_jm(),

                    //DateFormat("EEEE , dd-MM-yyyy 'at' h:mma"),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'ENTER  DATE AND TIME FOR MEETING',
                        hasFloatingPlaceholder: false
                    ),

                  ),

                  Padding(padding: EdgeInsets.only(bottom: 40.60),),

                  new RaisedButton(onPressed: (){
                    newtimevalue=newTimeSet.text;
                    debugPrint("$newtimevalue");
                    sendNewTime();
                    Navigator.pop(context,ModalRoute.withName('/'));

                    Navigator.pop(context,ModalRoute.withName('/'));
                  },
                  child: new Text("Send Meaasag",style: new TextStyle(color: Colors.white),),
                  color: Colors.green,
                  )



                ],
              )

            ],
          ),
        )
    );
  }


}