import 'package:flutter/material.dart';
import 'package:status/pages/photos.dart';
import 'package:status/pages/videos.dart';
//import 'package:firebase_admob/firebase_admob.dart';

//const String testDevice = '';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

//  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
//    //testDevices: <String>[],
//    keywords: <String>['live chat','dating','bigo'],
//  );

//  BannerAd _bannerAd;
//
//  BannerAd createBannerAd(){
//    return new BannerAd(
//      adUnitId: BannerAd.testAdUnitId,
//      size: AdSize.banner,
//      targetingInfo: targetInfo,
//      listener: (MobileAdEvent event){
//      }
//    );
//  }

//  InterstitialAd _interstitialAd;
//
//  InterstitialAd createInterstitialAd(){
//    return new InterstitialAd(
//        adUnitId: InterstitialAd.testAdUnitId,
//        targetingInfo: targetInfo,
//        listener: (MobileAdEvent event){
//        }
//    );
//  }

  @override
  void initState() {
    super.initState();
//    FirebaseAdMob.instance.initialize(appId: YOUR_APP_ID);
//    _bannerAd = createBannerAd()
//    ..load()
//    ..show();
  }
  
  @override
  void dispose(){
//    _bannerAd?.dispose();
//    _interstitialAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0xffe8e8e8),
      child: ListView(
        children: <Widget>[
          //Welcome and Balance Info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset.zero,
                    blurRadius: 3.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: (){
//                  createInterstitialAd()
//                    ..load()
//                    ..show();
                  Navigator.of(context).push( MaterialPageRoute(
                    builder: (BuildContext context) =>Photos(),
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Photo Status",style: TextStyle(
                      fontSize:24.0,
                      color:Colors.white,
                    )),
                    Text("Click here to view all photo status.",style: TextStyle(
                      fontSize:17.0,
                      color:Colors.white70,
                    )),

                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.all(Radius.circular(3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset.zero,
                    blurRadius: 3.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: (){
//                  createInterstitialAd()
//                    ..load()
//                    ..show();
                  Navigator.of(context).push( MaterialPageRoute(
                    builder: (BuildContext context) =>VideoListView(),
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Videos Status",style: TextStyle(
                      fontSize:24.0,
                      color:Colors.white,
                    )),
                    Text("Click here to view all videos status.",style: TextStyle(
                      fontSize:17.0,
                      color:Colors.white70,
                    )),
                  ],
                ),
              ),
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.all(Radius.circular(3)),
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
                  Text("File Manager > Downloaded Status ",style: TextStyle(
                    fontSize:20.0,
                    color:Colors.white,
                  )),
                  Padding(padding: EdgeInsets.all(5.0),),
                  Text("All photos and videos will be saved in Downloaded Status Folder.",style: TextStyle(
                    fontSize:17.0,
                    color:Colors.white70,
                  )),
                ],
              ),
            ),
          ), 
        ]
      ),
    );
  }
}