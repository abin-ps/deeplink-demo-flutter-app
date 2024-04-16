import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  String deepLinkUrl = '';

  final generatedUrlTextStyle = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //generate deeplink url button
            deepLinkUrl.isNotEmpty
                ? const SizedBox()
                : TextButton(
                    onPressed: () {
                      setState(() {
                        deepLinkUrl = 'https://simple-web-app-b8e17.web.app/';
                      });
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.white, textStyle: const TextStyle(fontSize: 20)),
                    child: const Text('Generate url')),

            ...deepLinkUrl.isEmpty
                ? []
                : [
                    //generated deeplink url
                    Text(
                      deepLinkUrl,
                      style: generatedUrlTextStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    //copy or reset deeplink url
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //copy deeplink url button
                        TextButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: deepLinkUrl));
                            },
                            style: TextButton.styleFrom(foregroundColor: Colors.white, textStyle: const TextStyle(fontSize: 20)),
                            child: const Text('Copy url')),
                        const SizedBox(width: 16),
                        //reset deeplink url button
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                deepLinkUrl = '';
                              });
                            },
                            style: TextButton.styleFrom(foregroundColor: Colors.white, textStyle: const TextStyle(fontSize: 20)),
                            child: const Text('Reset')),
                      ],
                    ),
                  ]
          ],
        ),
      ),
    );
  }
}
