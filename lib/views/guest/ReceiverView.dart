import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/tau.dart';

class ReceiverView extends StatefulWidget{
  const ReceiverView({super.key});

  @override
  State<ReceiverView> createState()  => _ReceiverViewState();

}

class _ReceiverViewState extends State<ReceiverView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Receiver')),
        body: const Center(
          child: ElevatedButton(
            onPressed: receiveVoice, child: Text("receive Voice"),
          ),
        )
    );
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