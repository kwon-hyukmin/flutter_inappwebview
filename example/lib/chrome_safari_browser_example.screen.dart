import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'main.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad(didLoadSuccessfully) {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }

  @override
  void onVerticalScrollEvent(bool isDirectionUp) {
    print("onVerticalScrollEvent $isDirectionUp");
  }

  @override
  void onGreatestScrollPercentageIncreased(int scrollPercentage) {
    print("onGreatestScrollPercentageIncreased $scrollPercentage");
  }

  @override
  void onSessionEnded(bool didUserInteract) {
    print("onSessionEnded $didUserInteract");
  }
}

class ChromeSafariBrowserExampleScreen extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser();

  @override
  _ChromeSafariBrowserExampleScreenState createState() =>
      _ChromeSafariBrowserExampleScreenState();
}

class _ChromeSafariBrowserExampleScreenState
    extends State<ChromeSafariBrowserExampleScreen> {
  @override
  void initState() {
    rootBundle.load('assets/images/flutter-logo.png').then((actionButtonIcon) {
      widget.browser.setActionButton(ChromeSafariBrowserActionButton(
          id: 1,
          description: 'Action Button description',
          icon: actionButtonIcon.buffer.asUint8List(),
          onClick: (url, title) {
            print('Action Button 1 clicked!');
            print(url);
            print(title);
          }));
    });

    widget.browser.addMenuItem(ChromeSafariBrowserMenuItem(
        id: 2,
        label: 'Custom item menu 1',
        image: UIImage(systemName: "sun.max"),
        onClick: (url, title) {
          print('Custom item menu 1 clicked!');
          print(url);
          print(title);
        }));
    widget.browser.addMenuItem(ChromeSafariBrowserMenuItem(
        id: 3,
        label: 'Custom item menu 2',
        image: UIImage(systemName: "pencil"),
        onClick: (url, title) {
          print('Custom item menu 2 clicked!');
          print(url);
          print(title);
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "ChromeSafariBrowser",
        )),
        drawer: myDrawer(context: context),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await widget.browser.open(
                    url: WebUri("https://flutter.dev/"),
                    settings: ChromeSafariBrowserSettings(
                        shareState: CustomTabsShareState.SHARE_STATE_OFF,
                        isSingleInstance: false,
                        isTrustedWebActivity: false,
                        keepAliveEnabled: true,
                        startAnimations: [
                          AndroidResource.anim(
                              name: "slide_in_left", defPackage: "android"),
                          AndroidResource.anim(
                              name: "slide_out_right", defPackage: "android")
                        ],
                        exitAnimations: [
                          AndroidResource.anim(
                              name: "abc_slide_in_top",
                              defPackage:
                                  "com.pichillilorenzo.flutter_inappwebviewexample"),
                          AndroidResource.anim(
                              name: "abc_slide_out_top",
                              defPackage:
                                  "com.pichillilorenzo.flutter_inappwebviewexample")
                        ],
                        dismissButtonStyle: DismissButtonStyle.CLOSE,
                        presentationStyle:
                            ModalPresentationStyle.OVER_FULL_SCREEN));
                await Future.delayed(Duration(seconds: 5));
                widget.browser.close();
              },
              child: Text("Open Chrome Safari Browser")),
        ));
  }
}
