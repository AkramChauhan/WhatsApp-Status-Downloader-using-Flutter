import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {


  @override
  void initState() {
    super.initState();
  }
  
  _launchURL() async {
    const url = 'https://flutterian.com';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not open App';
    }
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
      ),
      body: Container(
        color:Color(0xffe8e8e8),
        child: ListView(
          children: <Widget>[
            //Welcome and Balance Info
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset.zero,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("About Us",style: TextStyle(
                      fontSize:24.0,
                      color:Colors.white,
                    )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Text(
                    "Your About Us Content"
                    "\n\nAnother Line of About us content",
                    style: TextStyle(
                      fontSize:18.0,
                      color:Colors.indigo,
                    )),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                _launchURL();
                              },
                              padding: EdgeInsets.all(20.0),
                              child: Text("Read More Link",style: TextStyle(
                                fontSize:24.0,
                                color:Colors.white,
                              )),
                              color: Colors.indigo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
    
    
  }
}