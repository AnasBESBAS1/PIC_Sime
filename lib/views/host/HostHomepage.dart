import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:mic_stream/mic_stream.dart';

class HostHomepage extends StatefulWidget {
  const HostHomepage({super.key});
  @override
  State<HostHomepage> createState() => _HostHomepage();
}

class _HostHomepage extends State<HostHomepage> {
  final List<String> _hosts = ["kikoo","jijo","jawjaw","mimo"];
  final List<HostModel> _hostss = <HostModel>[];

  Future<String?> myLocalIp() async {
    final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4, includeLinkLocal: true);
    return interfaces
        .where((e) => e.addresses.first.address.indexOf('192.') == 0)
        ?.first
        ?.addresses
        ?.first
        ?.address;
  }

  Future<List<HostModel>> getAddresses() async{
    final scanner = LanScanner(debugLogging: true);
    final ip = await myLocalIp();
    var ipCopy = ip.toString();
    ipCopy = ipToCSubnet(ipCopy.toString());
    final stream = scanner.icmpScan(
      ipCopy.toString(),
      progressCallback: (progress) {
        if (kDebugMode) {
          print('progress: $progress');
        }
      },
    );
    stream.listen((HostModel host) {
      setState(() {
        _hostss.add(host);
      });
    });
    return _hostss;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PIC Network"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            backgroundColor: Colors.black,
          ),
          onPressed: sendVoice,
          child: const Text("send Voice"),
        ),
      ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        final scanner = LanScanner(debugLogging: true);
                        final ip = await myLocalIp();
                        var ipCopy = ip.toString();
                        ipCopy = ipToCSubnet(ipCopy.toString());
                        print("ip issss");
                        print(ipCopy);
                        final stream = scanner.icmpScan(
                          ipCopy.toString(), // To do : change with dynamic ip // done
                          progressCallback: (progress) {

                            if (kDebugMode) {
                              print('progress: $progress');
                            }
                          },
                        );
                        stream.listen((HostModel host) {
                          setState(() {
                            _hostss.add(host);
                          });
                        });
                        // Set the state of the widget here.
                      },
                         child: const Text(
                    'Connected devices',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ))),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final host = _hostss[index];

                return Card(
                  child: ListTile(
                    title: Text(host.ip),
                  ),
                );
              },
              itemCount: _hostss.length,
            ),
          ],
        ),
      ),
    );
  }
}

void sendVoice() async {

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
