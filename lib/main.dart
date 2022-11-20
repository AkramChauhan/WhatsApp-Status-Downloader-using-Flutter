import 'package:flutter/material.dart';
import 'package:status/includes/my_navigation_drawer.dart';
import 'package:status/pages/about_us.dart';
import 'package:status/pages/dashboard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status/pages/photos.dart';
import 'package:status/pages/videos.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _permissionChecked = false;
  late Future<int> _permissionChecker;

  Future<bool> checkPermission() async {
    bool result = await Permission.photos.request().isGranted;
    print("Checking Media Location Permission : " + result.toString());
    setState(() {
      _permissionChecked = true;
    });
    return result;
  }

  Future<int> requestPermission() async {
    // This is being called.
    openAppSettings();
    PermissionStatus result = await Permission.storage.request();
    if(result == PermissionStatus.granted) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();

    _permissionChecker = (() async {
      int finalPermission = 0;

      print("Initial Values of $_permissionChecked ");
      if (_permissionChecked == false) {
        PermissionStatus result = await Permission.storage.request();
        if (result == PermissionStatus.granted)
          finalPermission = 1;
      }
      print(finalPermission);
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
        future: _permissionChecker,
        builder: (context, status) {
          print(status);
          if (status.connectionState == ConnectionState.done) {
            if (status.hasData) {
              if (status.data == 1) {
                return MyHome();
              } else {
                return Scaffold(
                  body: Container(
                    color: Colors.lightBlue,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "File Read Permission Required",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Allow File Read Permission",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _permissionChecker = requestPermission();
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
                  color: Colors.lightBlue,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Something went wrong.. Please uninstall and Install Again.",
                            style: TextStyle(fontSize: 20.0),
                          ),
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
