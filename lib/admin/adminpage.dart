import 'package:flutter/material.dart';
class Adminpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new Admin();
  }


}

class Admin extends State<Adminpage>{
  Image image1,image2;

  @override
  void initState(){
    super.initState();
    image1=Image.asset("images/Logs.png");
    image2=Image.asset("images/registered.png");
  }
  @override
  void didChangeDependencies(){
      super.didChangeDependencies();
      precacheImage(image1.image, context);
      precacheImage(image2.image, context);
  }

  @override
  Widget build(BuildContext context) {
  
    return new Scaffold(
      
    backgroundColor: Colors.white,
               
      appBar: new AppBar(
        title:  new Text("ADMIN PAGE"),
        backgroundColor: Colors.green,
      ),

      body: 
      
      
      
      new ListView(
      
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 20.0),),
         
          new Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                new FlatButton(
              child: Image.asset("images/addfaculty2.png", height: 220.0, width: 145.0,),
              onPressed: ()=>debugPrint("ADD A FACULTY"),
            ),

            
            new FlatButton(
              child:Image.asset("images/removefaculty2.png",height: 220.0,width: 145.0,) ,
              onPressed: ()=>debugPrint("Remove Faculty"),
            ),
            ],
          ),
            
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
              new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 new FlatButton(
              child: Image.asset("images/Logs.png", height: 220.0, width: 145.0,),
              onPressed: ()=>debugPrint("Meetings"),
            ),

            new FlatButton(
              
              child:Image.asset("images/registered.png",height: 220.0,width: 145.0,) ,
              onPressed: ()=>debugPrint("Registered Persons"),
            ),
              ],
          )


          ],
      ),
     

      
    );
  }


}