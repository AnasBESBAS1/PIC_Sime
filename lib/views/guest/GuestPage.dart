import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/tau.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPage();
}

class _GuestPage extends State<GuestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PIC Network"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(children: [
                const SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Center(
                    child: Text(
                      'Welcome',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    backgroundColor: Colors.black, // Background color
                  ),
                  onPressed: receiveVoice,
                  child: const Text("receive Voice"),
                ),
              ]),
            )));
  }
}

void receiveVoice() async {
  FlutterSoundPlayer player = FlutterSoundPlayer();

  await player.openPlayer(enableVoiceProcessing: false);
  await player.startPlayerFromStream(numChannels: 1, sampleRate: 44100);
  final udpSocket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 9000);
  udpSocket.listen((RawSocketEvent event) {
    Uint8List? data = udpSocket.receive()?.data;
    if (data != null) {
      player.foodSink!.add(FoodData(data)); // this plays the audio
    } else {}
  });
}
