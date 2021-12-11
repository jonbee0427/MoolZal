import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Define App ID and Token
const APP_ID = '5717eea9a0b24b0a900ca448a3417fac';
const Token =
    '0065717eea9a0b24b0a900ca448a3417facIADfsH77KrUvAFiY5tqNLtikSVWgaPjJVqFyzxPK+ZQnr91Xb/YAAAAAEACSsTUmSS+1YQEAAQBJL7Vh';

class FaceCall extends StatefulWidget {
  @override
  _FaceCallState createState() => _FaceCallState();
}

class _FaceCallState extends State<FaceCall> {
  int? _remoteUid;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(Token, "moolzal_final", null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Call'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _engine.leaveChannel();
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 200,
              height: 200,
              child: Center(
                child: RtcLocalView.SurfaceView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid!);
    } else {
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
