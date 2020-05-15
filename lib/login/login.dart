import 'package:flutter/material.dart';
import 'package:welcome_page/admin/adminpage.dart';
import 'package:fluttertoast/fluttertoast.dart';


var usernameadmin="dbitadmin";
var password ="dbit";

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new Loginstate();
  }


}


class Loginstate extends State<Login>{

  final TextEditingController _usercontroller = new TextEditingController();
  final TextEditingController _passwordcontroller = new TextEditingController();
  String wel="";
  void _erase(){
    setState(() {
     _usercontroller.clear();
     _passwordcontroller.clear(); 
     wel="";
    });
  }

  void _userwelcome(){
    setState(() {
     if(_usercontroller.text.isNotEmpty && _passwordcontroller.text.isNotEmpty)
     {
        Navigator.push(context, new MaterialPageRoute(builder: (context)=>Adminpage()));
     } 
    });
  }

  void error(){

    Fluttertoast.showToast(msg: "Incorrect UserName or Password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(" Admin Login Page"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),



      body: new Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: new ListView(
          
          children: <Widget>[

           
            //IMAGES
            Padding(padding: EdgeInsets.only(bottom: 20.0),),
              new Image.asset('images/DBIT.png',
            width: 200.0,
            height: 200.0,
            ), 
            

            
 
            
           
           new Padding(padding: new EdgeInsets.all(15.60),),
     
          new Padding(padding: new EdgeInsets.all(5.60),),
          new Container(
            margin: EdgeInsets.only(right: 20.0),
            child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: <Widget>[
                   new TextField(
              
              controller: _usercontroller,
              decoration:new InputDecoration(
                hintText:'UserName',
                 icon : new Icon(Icons.person),
              ),
              
            ),
            Padding(padding: EdgeInsets.only(bottom:15.0),),
            new TextField(
              
              controller: _passwordcontroller,
              decoration: new InputDecoration(
                icon: new Icon(Icons.lock),
                hintText: 'Password'
              ),
              obscureText: true,
            ),
          


            ],
            ),
          ),

          

          new Padding(padding: new EdgeInsets.all(30.60),),
          
          //new Center(
            
            new Row(
             
              children: <Widget>[
                new Container(
                    margin: EdgeInsets.only(left: 30.60),
                    child:new RaisedButton(
                   
                  child: new Text("Login",style: new TextStyle(color: Colors.white),),
                  onPressed: (_usercontroller.text==usernameadmin) && (_passwordcontroller.text==password)? _userwelcome:error,
                  color: Colors.green,
                ),),
               
               new Container(
                 decoration: BoxDecoration(
                  
                 ),
                    margin: EdgeInsets.only(left: 120.60),
                    child:new RaisedButton(
                   
                  child: new Text("Clear",style: new TextStyle(color: Colors.white)),
                  onPressed:  _erase,
                  color: Colors.green,
                  
                ),
                   
                


                )
              
                  
              ],
            ) ,
              //  ), //form ends here

          
      
                      ],
        ), 



      ),
      
      
    );
  }


}