import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// #FOR TESTING

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Launch Payment App'),
        ),
        body: Center(
          heightFactor: 1.2,
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _launcherUrlToClick("https://my.click.uz/");
                  },
                  child: Text('Pay with Click'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _launcherUrlToClick("https://payme.uz/home/");
                  },
                  child: Text('Pay with PayMe'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launcherUrlToClick(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
