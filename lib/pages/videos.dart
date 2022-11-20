import 'dart:io';
import 'package:flutter/material.dart';
import 'package:status/pages/video_play.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final Directory _videoDir = new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoListView extends StatefulWidget {
  @override
  VideoListViewState createState() {
    return new VideoListViewState();
  }
}

class VideoListViewState extends State<VideoListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_videoDir.path}").existsSync()) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Whatsapp Video Status"),
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Center(
            child: Text(
              "Install WhatsApp\nYour Friend's Status will be available here.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Whatsapp Video Status"),
        ),
        body: VideoGrid(directory: _videoDir),
      );
    }
  }
}

class VideoGrid extends StatefulWidget {
  final Directory directory;

  const VideoGrid({Key? key, required this.directory}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  _getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String? thumb = await VideoThumbnail.thumbnailFile(
        video: videoPathUrl, maxWidth: 250, imageFormat: ImageFormat.WEBP, quality: 10);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    var videoList = widget.directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false);
    if (videoList.length > 0) {
      return Container(
        padding: EdgeInsets.only(bottom: 60.0),
        child: ListView.builder(
          itemCount: videoList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new PlayStatusVideo(videoList[index])),
                ),
                child: FutureBuilder(
                    future: _getImage(videoList[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Hero(
                                tag: videoList[index],
                                child: Stack(
                                  alignment: Alignment.center,
                                children: [
                                  Container(
                                    child: Image.file(File(snapshot.data.toString()))
                                  ),
                                  Container(
                                    width: 150,
                                    alignment: Alignment.bottomCenter,
                                    height: 150,
                                    child: Image.asset("assets/images/play_icon.png"),
                                  )
                                ])
                              ),
                            ],
                          );
                          // Expanded(
                          //   child: Column(
                          //       children: <Widget>[
                          //         Hero(
                          //           tag: videoList[index],
                          //           child: Image.file(File(snapshot.data.toString())),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          //           child: ElevatedButton(
                          //             child: Text("Play Video"),
                          //             onPressed: () {
                          //               Navigator.push(context, new MaterialPageRoute(
                          //                   builder: (context)=>new PlayStatusVideo(videoList[index])
                          //               ),);
                          //             },
                          //           ),
                          //         ),
                          //       ]
                          //   ),
                          // );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      } else {
                        return Container(
                          child:
                          Image.asset("assets/images/video_loader.gif"),
                        );
                      }
                    }),
              ),
            );
          },
        ),
      );
    } else {
      return Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Text(
            "Sorry, No Videos Found.",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }
}
