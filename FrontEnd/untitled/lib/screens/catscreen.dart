import 'package:flutter/material.dart';
import 'package:untitled/screens/mainpage.dart';
import 'package:video_player/video_player.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});
  @override
  State<CatScreen> createState() => _MyCatState();
  // final String Urls = '!!';
  // controller = VideoPlayerController.Urls(Uri.parse())
  // _MyCatState createState() => _MyCatState();
}

class _MyCatState extends State<CatScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('CatIoT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
        centerTitle: true,
        backgroundColor: Colors.pink,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Center(
              child: Column(
                children: [
                  SizedBox(height: 300),
                  Text(
                    '우리집 고양이 보러가는중...',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text('우리 고양이의 모습은?'),
      //       Container(
      //         padding: EdgeInsets.all(30),
      //         margin: EdgeInsets.all(10),
      //         width: 400,
      //         height: 400,
      //         decoration:
      //             BoxDecoration(border: Border.all(color: Colors.green)),
      //         child: Column(
      //           children: [
      //             // Image.network(Urls),
      //             // controller.play(),
      //             Text('★★★★홈캠★★★★'),
      //           ],
      //         ),
      //       ),
      //       TextButton(
      //           style: TextButton.styleFrom(
      //             backgroundColor: Colors.pink,
      //           ),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => MainScreen(),
      //                 ));
      //           },
      //           child: Text(
      //             '메인으로 돌아가기',
      //             style: TextStyle(
      //               color: Colors.white,
      //             ),
      //           ))
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/health');
              break;
            case 1:
              Navigator.pushNamed(context, '/catview');
            case 2:
              Navigator.pushNamed(context, '/catview');
            // default:
            //   Navigator.pushNamed(context, '/health');
            // ***디폴트 경로 설정: 필요할 경우 추가하기***
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: '건강 체크'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: '고양이 보기'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: '고양이 정보?'),
        ],
      ),
    );
  }
}
