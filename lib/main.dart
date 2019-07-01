import 'package:flutter/material.dart';
import 'package:status_download/includes/myNavigationDrawer.dart';
import 'package:status_download/pages/about_us.dart';
import 'package:status_download/pages/dashboard.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:status_download/pages/photos.dart';
import 'package:status_download/pages/videos.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _readPermissionCheck;
  bool _writePermissionCheck;
  Future<int> _readwritePermissionChecker;

  Future<bool> checkReadPermission() async {
    bool result = await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
    print("Checking Read Permission : "+result.toString());
    setState(() {
      _readPermissionCheck = true;
    });
    return result;
  }
  Future<bool> checkWritePermission() async {
    bool result = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    print("Checking Write Permission : "+result.toString());
    setState(() {
      _writePermissionCheck = true;
    });
    return result;
  }

  Future<int> requestReadPermission() async {
    PermissionStatus result = await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    if(result.toString()=="PermissionStatus.denied"){
      return 0;
    }else if(result.toString()=="PermissionStatus.authorized"){
      return 1;
    }else{
      return 0;
    }
  }
  Future<int> requestWritePermission() async {
    PermissionStatus result = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    print("Requesting Write Permission $result");
    if(result.toString()=="PermissionStatus.denied"){
      return 1;
    }else if(result.toString()=="PermissionStatus.authorized"){
      return 2;
    }else{
      return 1;
    }
  }

  @override
  void initState() {
    super.initState();

    _readwritePermissionChecker = (() async {
      int readPermissionCheckInt;
      int writePermissionCheckInt;
      int finalPermission;


      print("Initial Values of $_readPermissionCheck AND $_writePermissionCheck");
      if(_readPermissionCheck==null || _readPermissionCheck==false){
        _readPermissionCheck = await checkReadPermission();
      }else{
        _readPermissionCheck = true;
      }
      if(_readPermissionCheck){
        readPermissionCheckInt = 1;
      }else{
        readPermissionCheckInt = 0;
      }

      if(_writePermissionCheck==null || _writePermissionCheck==false){
        _writePermissionCheck = await checkWritePermission();
      }
      if(_writePermissionCheck){
        writePermissionCheckInt = 1;
      }else{
        writePermissionCheckInt = 0;
      }
      if(readPermissionCheckInt==1){
        if(writePermissionCheckInt==1){
          finalPermission=2;
        }else{
          finalPermission=1;
        }
      }else{
        finalPermission=0;
      }
      return finalPermission;
    })();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Downloader',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _readwritePermissionChecker,
        builder: (context, status) {
          if (status.connectionState == ConnectionState.done) {
            if (status.hasData) {
              if(status.data==2){
                return MyHome();
              }else if(status.data==1){
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.lightBlue[100],
                          Colors.lightBlue[200],
                          Colors.lightBlue[300],
                          Colors.lightBlue[200],
                          Colors.lightBlue[100],
                        ],
                      )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Write Permission Required", style: TextStyle(
                              fontSize: 20.0
                            ),),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(15.0),
                            child: Text("Allow Write Permission",style: TextStyle(
                              fontSize:20.0
                            ),),
                            color: Colors.indigo,
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                _readwritePermissionChecker = requestWritePermission();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.lightBlue[100],
                          Colors.lightBlue[200],
                          Colors.lightBlue[300],
                          Colors.lightBlue[200],
                          Colors.lightBlue[100],
                        ],
                      )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("File Read Permission Required", style: TextStyle(
                              fontSize: 20.0
                            ),),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(15.0),
                            child: Text("Allow File Read Permission", style: TextStyle(
                              fontSize: 20.0,
                            ),),
                            color: Colors.indigo,
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                _readwritePermissionChecker= requestReadPermission();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.lightBlue[100],
                        Colors.lightBlue[200],
                        Colors.lightBlue[300],
                        Colors.lightBlue[200],
                        Colors.lightBlue[100],
                      ],
                    )
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("Something went wrong.. Please uninstall and Install Again.", style: TextStyle(
                            fontSize: 20.0
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              body: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
      ),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => DashboardScreen(),
        "/photos": (BuildContext context) => Photos(),
        "/videos": (BuildContext context) => VideoListView(),
        "/aboutus": (BuildContext context) => AboutScreen(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download WhatsApp Status"),
        //elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: DashboardScreen(),
      drawer: Drawer(
        child: MyNavigationDrawer(),
      ),
    );
  }
}
