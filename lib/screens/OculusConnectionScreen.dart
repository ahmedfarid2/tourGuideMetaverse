import 'package:flutter/material.dart';

class OculusConnectionScreen extends StatelessWidget {
  static const String routeName = "oculus_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Your Oculus Quest'),
        backgroundColor: Colors.orange[900],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/oculus.png',
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 40),
              const Text(
                'To join the MetaPharaoh metaverse, please follow these steps:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Step 1: Download the Oculus app on your mobile device.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Step 2: Connect your Oculus Quest headset to the companion app.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Step 3: Once connected, open the MetaPharaoh app on your headset.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Open a URL or deep link to the Oculus companion app
                  // You can use a package like url_launcher to achieve this.
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange[900]!),
                ),
                child: const Text('Download Oculus App'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
