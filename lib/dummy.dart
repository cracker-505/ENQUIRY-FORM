// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncherWid extends StatefulWidget {
  const URLLauncherWid({Key? key}) : super(key: key);

  @override
  State<URLLauncherWid> createState() => _URLLauncherWidState();
}

class _URLLauncherWidState extends State<URLLauncherWid> {
  // for opening url
  void profile(String host) async {
    Uri url = Uri.parse(host);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw "Can't launch link";
    }
  }

  //for call
  void call() async {
    Uri url = Uri(scheme: 'tel', path: '+9644856621');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Can't launch call";
    }
  }

  //for sending mail
  void mail() async {
    Uri url = Uri(scheme: 'mailto', path: "lvikramsah@gmail.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Can't launch mail";
    }
  }

  //for sending message
  void msg() async {
    Uri url = Uri(scheme: 'sms', path: "+9779801234567");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Can't launch message";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: IconButton(
                  onPressed: () => call(),
                  icon: Icon(
                    Icons.call,
                  )),
            ),
            Center(
              child: IconButton(
                  onPressed: () => mail(),
                  icon: Icon(
                    Icons.email,
                  )),
            ),
            Center(
              child: IconButton(
                  onPressed: () => msg(),
                  icon: Icon(
                    Icons.message,
                  )),
            ),
            Center(
              child: IconButton(
                  onPressed: () =>
                      profile('https://www.github.com/lakshydeep-14/'),
                  icon: Icon(
                    FontAwesomeIcons.github,
                  )),
            ),
            Center(
              child: IconButton(
                  onPressed: () =>
                      profile('https://www.linkedin.com/in/lakshydeep-14/'),
                  icon: Icon(
                    FontAwesomeIcons.linkedin,
                  )),
            ),
            Center(
              child: IconButton(
                  onPressed: () => profile('https://lakshydeep-14.medium.com'),
                  icon: Icon(
                    FontAwesomeIcons.medium,
                  )),
            ),
            Center(
              child: IconButton(
                  onPressed: () =>
                      profile('https://github.com/lakshydeep-14/30FlutterTips'),
                  icon: Icon(
                    Icons.link,
                  )),
            )
          ]),
    );
  }
}
