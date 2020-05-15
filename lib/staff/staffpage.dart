import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:welcome_page/staff/staff.dart';

int count=0;
var _staffusrcontroller = new TextEditingController();
var _staffpasswordcontroller = new TextEditingController();
var facultyname;
String staff_email = _staffusrcontroller.text;
final GlobalKey<ScaffoldState> _sck = new GlobalKey<ScaffoldState>();
String staffPassword = _staffpasswordcontroller.text;
class StaffLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new StaffLoginstate();
  }


}

class StaffLoginstate extends State<StaffLogin>{
  String phoneNumber;
  String smsCode;
  String verificationCode;
  String wel="";



  void _erase(){
    setState(() {
      _staffusrcontroller.clear();
      _staffpasswordcontroller.clear();
      wel="";
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _sck,
      appBar: new AppBar(
        title: new Text("Staff Login Page"),
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
                    maxLines: 1,
                    controller: _staffusrcontroller,
                    keyboardType:TextInputType.emailAddress ,
                    decoration:new InputDecoration(
                      hintText:'Email id',
                      icon : new Icon(Icons.person),
                    ),
                    autofocus: false,
                    onChanged: (value)=>
                    staff_email = value,

                  ),
                  Padding(padding: EdgeInsets.only(bottom:15.0),),
                  new TextField(

                    controller: _staffpasswordcontroller,
                    decoration: new InputDecoration(
                        icon: new Icon(Icons.lock),
                        hintText: 'Password'
                    ),
                    obscureText: true,
                    onChanged: (value)=>
                    staffPassword = value,
                  ),



                ],
              ),
            ),





            new Padding(padding: new EdgeInsets.all(30.60),),
            new StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('staff').snapshots(),
              builder: (_,snapshot){
                if(snapshot.hasData==null){
                  return new Text("Loading");
                }
                else{
                  return new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        child:new RaisedButton(

                          child: new Text("Login", style:new TextStyle(color: Colors.white)),
                          onPressed:() {
                            setState(() {
                              if(_staffusrcontroller.text.isEmpty || _staffpasswordcontroller.text.isEmpty)
                              {
                                final snackbar = SnackBar(content: Text("Email or Password is empty"),duration: Duration(seconds: 6),);
                                _sck.currentState.showSnackBar(snackbar);
                                facultyname=_staffusrcontroller.text;
                               // Scaffold.of(context).showSnackBar(snackbar);
                              }
                              else{
                                count = 0;
                                handleSignIn().then((FirebaseUser user){
                                 print("go to admin");
                                 count+=1;
                                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>Staffpage()));
                                }).catchError((
                                   e)=>print(e));
                              }

//                                var len = snapshot.data.documents.length;
//                                for(var i=0;i<len;i++){
//                                  DocumentSnapshot ds = snapshot.data.documents[i];
//                                  if(_staffusrcontroller.text == ds.data['email'] &&
//                                  _staffpasswordcontroller.text == ds.data['password']){
//                                    count +=1;
//
//                                     Navigator.push(context, new MaterialPageRoute(builder: (context)=>Adminpage()));
//                                     break;
//                                  }
//                                }
//                                if(count == 0){
//                                  _sck.currentState.showSnackBar(SnackBar(content: Text("Email or Password is wrong"),duration: Duration(seconds: 6)));
//                                }

                            });
                          },
                          color: Colors.green,
                        ),),

                      new Container(
                        decoration: BoxDecoration(

                        ),
                        margin: EdgeInsets.only(left: 120.60),
                        child:new RaisedButton(

                          child: new Text("Clear",style:new TextStyle(color: Colors.white)),
                          onPressed:  _erase,
                          color: Colors.green,

                        ),




                      )


                    ],
                  );
                }
              },
            )

            //new Center(


//            //  ), //form ends here



          ],
        ),



      ),


    );
  }

  Future<FirebaseUser> handleSignIn()async {
    var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: staff_email, password:staffPassword );
    final FirebaseUser user = result.user;
    final FirebaseUser currentuser = await FirebaseAuth.instance.currentUser();
    assert(user.uid==currentuser.uid);
    assert(user!=null);
    assert(await user.getIdToken()!=null);
    print("SignIn successed");
    return user;
  }


}