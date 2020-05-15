import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welcome_page/staff/staff.dart';
import 'package:welcome_page/staff/staffpage.dart';
import 'Details/detailspage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:welcome_page/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:welcome_page/fetchnew.dart';
import 'admin/adminpage.dart';
import 'package:welcome_page/Details/detailspage.dart';
import 'package:welcome_page/Details/details.dart';
import 'package:welcome_page/staff/newTime.dart';
import 'package:welcome_page/confirm/confirmdetails.dart';

//import 'package:welcome_page/detailspage_for_visited.dart';
import 'package:image_picker/image_picker.dart';


final PermissionHandler _permissionHandler = PermissionHandler();
TextEditingController mob= TextEditingController();
TextEditingController otp= TextEditingController();
final GlobalKey<ScaffoldState> _sck = new GlobalKey<ScaffoldState>();

bool chk = false;
var useremail,userDocument;
 var phone;
var temp3;

//var faculty = ['abcd'];
var tempfaculty = new List();
var ran2;
var ran = new Random();
//Homepage.getdata();

// CONFIRM MESSAGE CODE PLEASE DO NOT DELETE
 const platform = const MethodChannel('sendSms');
Future<Null> sendConfirm()async {

  phone=mob.text.isEmpty?"NO NUMBER":mob.text;
  print("SendSMS");
  try {
    print("$phone");
    final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"$phone","msg":"Your Request To Meet $SelectedFaculty was Sucessfully Send Please Wait For Confirmation Message"}); //Replace a 'X' with 10 digit phone number

    print(result);
  } on PlatformException catch (e) {
    print(e.toString());
  }
}
// END OF CONFIRM MESSAGE

// Accept Message PLEASE DO NOT DELETE
Future<Null> sendAccept()async {

  phone=phoneNo==null?"NO NUMBER":phoneNo;
  print("SendSMS");
  try {
    print("$phone");
    final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"$phone","msg":"Your Meeting Has been Confirmed."}); //Replace a 'X' with 10 digit phone number

    print(result);
  } on PlatformException catch (e) {
    print(e.toString());
  }
}
// END OF ACCEPT

// NEW TIME MESSAGE PLEASE DO NOT DELETE
Future<Null> sendNewTime()async {

  phone=phoneNo==null?"NO NUMBER":phoneNo;
  print("SendSMS");
  try {
    print("$phone");
    final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"$phone","msg":"Your Meeting Has been Confirmed And Has Been Scheduled at new Time $newtimevalue"}); //Replace a 'X' with 10 digit phone number

    print(result);
  } on PlatformException catch (e) {
    print(e.toString());
  }
}
//


// MESSAGE FOR FACULTY PLS DO NOT DELETE
Future<Null> sendFacultyMessage()async {
  print(facultyPhone);
  print("SendSMS");
  print("Hello");
  try {
    print("faculty phone $facultyPhone");
    final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"$facultyPhone","msg":"HELLO! You Have A New Visitor Requesr In DBIT-VISITOR MANAGEMENT"}); //Replace a 'X' with 10 digit phone number

    print(result);
  } on PlatformException catch (e) {
    print(e.toString());
  }
}
// END FOR FACULTY MESSAGE

Future<bool> requestPermission(PermissionGroup permission) async {
  var result = await _permissionHandler.requestPermissions([permission]);
  if (result[permission] == PermissionStatus.granted) {
    return true;
  }
  return false;
}

Future<bool> requestSmsPermission() async {
  return requestPermission(PermissionGroup.sms);
}




void main()
{




    runApp(
        new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "HOME PAGE",
          home: Home(),

        )
    );


}


class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new Homepage();
  }



}

class Homepage extends State<Home>{
  var permission=requestSmsPermission();
  String phoneNumber;
  String smsCode;
  String verificationCode;

  @override
  initState(){

    super.initState();
  }






  int next(int min, int max) => min + ran.nextInt(max - min);

  //static const platform = const MethodChannel('sendSms');
  Future<Null> sendSms()async {

     phone=mob.text.isEmpty?"NO NUMBER":mob.text;
     ran2=next(1101, 9998);

    print("$ran2");
   print("SendSMS");
    try {
      print("$phone");
      final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"$phone","msg":"Your OTP is $ran2"}); //Replace a 'X' with 10 digit phone number

      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }


  Future<void> _submit() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationCode = verId;
      print("$phone"+"Mynumber");
      print("Timeout");
    };

    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("Signed In"));
    };

    final PhoneVerificationCompleted phoneVerificationCompleted = (AuthCredential credential) {
      print("Success");
    };

    final PhoneVerificationFailed phoneVerificationFailed = (
        AuthException exception) {
      print("${exception.message}");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:phone,
        timeout: const Duration(seconds: 40),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Code"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text("Verify"),
                onPressed: (){
                  FirebaseAuth.instance.currentUser().then((user) {
                    if(user != null) {
                      print("Already Exists");
                      Navigator.of(context).pop();
                      chk = false;
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Details(
                        //data: faculty,
                      )));
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              ),
            ],
          );
        }
    );
  }


  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(verificationId:verificationCode , smsCode: smsCode);
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) =>Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Details())))
        .catchError((e) => print(e));
  }


 
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        key: _sck,
      drawer: Drawer(
        child: new Container(
          color: Colors.white,
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 50.0),),
            new Image.asset("images/DBIT.png",height: 150.0,width: 150.00,),
            Padding(padding: EdgeInsets.only(bottom: 40.0),),

            new Container(
              height: 7.0,
              color: Colors.green,
            ),
          Padding(padding: EdgeInsets.only(bottom: 40.0),),
          new Container(

              child:
              new Column(

                children: <Widget>[
                  new Container(

                    child: new ListTile(

                      onTap: () async {
                        //ADD STAFF LOGIN HERE
                        FirebaseUser u = await FirebaseAuth.instance.currentUser();
                        if(u!=null)
                        {
                          print(u.email);
                          useremail = u.email;
                          print(u.phoneNumber);
                          Firestore.instance.collection('staff').getDocuments().then((val)
                          {
                            var lengthDB = val.documents.length;
                            for(var i=0;i<lengthDB;i++){
                              if(val.documents[i].data['email'] == useremail){
                                userDocument = val.documents[i].documentID;
                              }
                            }
                          });
                          print(userDocument);
                          Navigator.push(context,new MaterialPageRoute(builder: (context)=>new Staffpage()));


                        }
                        else {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new StaffLogin()));
                        }


                      },
                      leading: new Icon(Icons.person,color:Colors.green,size: 30.0,),
                      title: new Text("STAFF LOGIN",textAlign: TextAlign.start,style: new TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.w900,fontSize: 20.0),
                      ),
                    ) ,
                  ),

                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  new Container(

                    child: new ListTile(

                      onTap:(){
//                        Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Login()));
                          print("About");
                      },
                      leading: new Icon(Icons.account_circle,color:Colors.green,size: 30.0,),
                      title: new Text("ABOUT",textAlign: TextAlign.start,style: new TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.w900,fontSize: 20.0)),

                    ),
                  ),

                ],
              )

          ),

//
//            new RaisedButton(onPressed:() {
//              Navigator.push(context,new MaterialPageRoute(builder: (context)=>new Login()));
//
//            }
//            ,child:new Text("ADMIN LOGIN"),color: Colors.greenAccent.shade400,),

            //Padding(padding: EdgeInsets.only(bottom: 50.0),),
           // new Image.asset("images/user.png",height: 150.0,width: 150.00,),

            //Padding(padding: EdgeInsets.only(bottom: 30.0),),
            /*new RaisedButton(onPressed:()async{
              FirebaseUser u = await FirebaseAuth.instance.currentUser();
              if(u!=null){
                print(u.email);
                useremail = u.email;
                print(u.phoneNumber);
                Firestore.instance.collection('staff').getDocuments().then((val)
                {
                    var lengthDB = val.documents.length;
                    for(var i=0;i<lengthDB;i++){
                      if(val.documents[i].data['email'] == useremail){
                        userDocument = val.documents[i].documentID;
                      }
                    }
                                    });
                print(userDocument);
                Navigator.push(context,new MaterialPageRoute(builder: (context)=>new Staffpage()));
              }
              else {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new StaffLogin()));
              }
            },
              child:new Text("STAFF LOGIN"),color: Colors.greenAccent.shade400,),*/



          ],),
        ),

      ),

       appBar: new AppBar(
         backgroundColor: Colors.green,
         centerTitle: true,
         title: new Text("VISITOR MANAGEMENT"),
      ),


      body:
      new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top:20),),
            new Center(child: new Text("WELCOME",style: new TextStyle(fontSize: 25.0,fontWeight: FontWeight.w900,color: Colors.green.shade700),),),
            
            Padding(padding: EdgeInsets.only(top: 10.0),),
            new Container(
             // color: Colors.greenAccent,
            
              margin: EdgeInsets.only(right: 20.0),
              
              child:
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                       new TextField(
                         maxLength: 10,
                        decoration: InputDecoration(
                        icon: new Icon(Icons.phone),
                        hintText: "Enter Mobile Number",

                        ),
                        keyboardType: TextInputType.number,
                        controller: mob,
                    ),
                       
                      new Container(
                        alignment: Alignment.centerRight,
                        child:new IconButton(
                        alignment: Alignment.topLeft,
                        onPressed : ()=>sendSms(),
                         // print("Re""turn .....");
                          //},
                        //_submit,

                        icon: new Icon(Icons.arrow_forward),
                      ),

                      ),

                       new Container(

                       child:   new TextField(

                      decoration: InputDecoration(
                        icon: new Icon(Icons.lock),
                        hintText: "Enter OTP",
                        ),

                         keyboardType: TextInputType.number,
                        controller: otp,
                    ),


                    ),


                    new Container(

                      height: 250.0,
                      margin: EdgeInsets.only(left: 50.0),
                      child:
                       new Image.asset('images/visitor.png' ,width: 350.0,height: 320.0,alignment: Alignment.center),


                    ),
                   

                  ],
              ),
              ),

            new Container(
              alignment: Alignment.center,
              child: 
              new RaisedButton(

                //onPressed: ()=>Navigator.push(context,  new MaterialPageRoute(builder: (context)=>new Try11())) ,
                onPressed:() {
                    print(otp.text);

                  if(ran2.toString()==otp.text){
                    username.clear();
                    email.clear();
                    imagepic=null;
                    idpic=null;
                    currentvalue=null;
                    SelectedFaculty=null;
                    facultydisplay=[];
                    print("MOBILE NO : ${mob.text}");
                    name.clear();
                    time.clear();
                    temp3=mob.text;
                    print("Temp $temp3");
                    previously_visited();
                    Navigator.push(
                        context, new MaterialPageRoute(builder: (context) =>
                    new Details(
                      //data: faculty,
                    )));
                  }else {
                    final snackbar = SnackBar(content: Text("Invalid Mobile Number or OTP"),duration: Duration(seconds: 6),);
                    _sck.currentState.showSnackBar(snackbar);
                  print("otp not verified");

                  otp.clear();


                  }
                 // if(bool==true) {

                  //}
                },
                color: Colors.green,
                child: new Text("CHECK IN",style: new TextStyle(fontSize: 20,color: Colors.white),),
                ),
          

            )
           
          ],
        ),
      )

    );

  }

}