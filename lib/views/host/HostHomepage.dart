import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';

class HostHomepage extends StatefulWidget {
  const HostHomepage({super.key});

  @override
  State<HostHomepage> createState() => _HostHomepage();
}

class _HostHomepage extends State<HostHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PIC Network"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(40),
            backgroundColor: Colors.black, // Background color
          ),
          onPressed: sendVoice,
          child: Text("send Voice"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Center(
                  child: Text(
                    'Connected devices',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            ListTile(
              title: const Text('kiko...'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('kiko...'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('kiko...'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('kiko...'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
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
