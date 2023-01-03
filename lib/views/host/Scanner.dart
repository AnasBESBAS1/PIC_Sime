import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';

class ScannerWidget extends StatefulWidget {
  const ScannerWidget({Key? key}) : super(key: key);

  @override
  State<ScannerWidget> createState() => _ScannerWidget();
}

class _ScannerWidget extends State<ScannerWidget> {
  final List<HostModel> _hosts = <HostModel>[];

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
        _hosts.add(host);
      });
    });
    return _hosts;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanning network...'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: Colors.black, // Background color
                  ),
                  onPressed: () async {
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
                        _hosts.add(host);
                      });
                    });
                  },
                  child: const Text(
                    'Scan',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final host = _hosts[index];

                  return Card(
                    child: ListTile(
                      title: Text(host.ip),
                    ),
                  );
                },
                itemCount: _hosts.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
