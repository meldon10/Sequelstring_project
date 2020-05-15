import 'package:flutter/material.dart';
import 'package:welcome_page/fetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:welcome_page/staff/staffpage.dart';
import 'package:welcome_page/fetch_Past.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Staffpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new StaffpageState();

  }


}

class StaffpageState extends State<Staffpage>{
  Image image1,image2;
  var _firebaseAuth = FirebaseAuth.instance;
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

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      backgroundColor: Colors.white,

      appBar: new AppBar(
        title:  new Text("STAFF PAGE"),
        backgroundColor: Colors.green,

        actions: <Widget>[
          new IconButton(icon: new Icon( Icons.exit_to_app,color: Colors.white,size: 30.0,), onPressed:(){
            Fluttertoast.showToast(msg: "Sign Out",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP);
            signOut();
          Navigator.push(context, new MaterialPageRoute(builder: (context)=>StaffLogin()));
          }),
        ],



      ),

      body:



      new ListView(

        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 20.0),),


          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

                new FlatButton(

                child:Image.asset("images/registered.png",height: 220.0,width: 145.0,) ,
                onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder:(context)=>new FacultyLog(
                  ),
                  ),
                  );

                }
                ),

                new FlatButton(
                child: Image.asset("images/Logs.png", height: 220.0, width: 145.0,),
                onPressed: ()=>Navigator.push(context,new MaterialPageRoute(builder:(context)=>new FacultyLog2(),
                ),
                ),

              ),


            ],
          )


        ],
      ),



    );
  }


}