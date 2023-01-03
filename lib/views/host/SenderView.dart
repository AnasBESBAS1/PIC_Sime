// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';

class SenderView extends StatefulWidget{
  const SenderView({super.key});
  @override
  State<SenderView> createState()  => _SenderViewState();
}

class _SenderViewState extends State<SenderView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Sender')),
        body: const Center(
          child: ElevatedButton(
            onPressed: sendVoice, child: Text("send Voice"),
          ),
        )
    );
  }
}

void sendVoice() async {
  // final _networkInfo = NetworkInfo();
  // var wifiBroadcast = await _networkInfo.getWifiBroadcast(); // 192.168.43.255
  Stream<Uint8List>? stream = await MicStream.microphone(
    sampleRate: 44100,
    audioFormat: AudioFormat.ENCODING_PCM_16BIT,
  );

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
    socket.broadcastEnabled = true;
    StreamSubscription<List<int>> listener = stream!.listen((sample) async {
      socket.send(sample, InternetAddress("192.168.43.255"), 9000);
    });
  });
}