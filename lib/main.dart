import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Example for EmojiPickerFlutter
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();

  bool emojiShowing = false;

  _onEmojiSelected(Emoji emoji) {
    // ignore: avoid_print
    print('_onEmojiSelected: ${emoji.emoji}');
  }

  _onBackspacePressed() {
    // ignore: avoid_print
    print('_onBackspacePressed');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  FocusNode keyboardFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    keyboardFocusNode.addListener(() {
      if (keyboardFocusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            'Emoji Picker App',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                child: const Center(
                  child: Text(
                    "Hi Coder !!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
            WillPopScope(
              child: Container(
                color: Colors.deepPurpleAccent,
                child: Row(
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.camera_circle_fill,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: _controller,
                            focusNode: keyboardFocusNode,
                            keyboardType: TextInputType.multiline,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 10,
                            minLines: 1,
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Send a message...',
                              filled: true,
                              isCollapsed: true,
                              fillColor: Colors.white,
                              prefixIcon: IconButton(
                                icon: const Icon(
                                  CupertinoIcons.smiley_fill,
                                  color: Colors.yellow,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  keyboardFocusNode.unfocus();
                                  keyboardFocusNode.canRequestFocus = false;
                                  setState(() {
                                    emojiShowing = !emojiShowing;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  CupertinoIcons.square_grid_2x2_fill,
                                  color: Colors.greenAccent,
                                ),
                                onPressed: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (builder) => bottomSheet(),
                                  );
                                },
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 16.0,
                                  bottom: 8.0,
                                  top: 8.0,
                                  right: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                        child: IconButton(
                            onPressed: () {
                              // send message
                            },
                            icon: const Icon(
                              Icons.telegram_rounded,
                              color: Colors.white,
                              size: 40.0,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              onWillPop: () {
                if (emojiShowing) {
                  setState(() {
                    emojiShowing = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
            Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                height: 300,
                child: EmojiPicker(
                  textEditingController: _controller,
                  onEmojiSelected: (Category category, Emoji emoji) {
                    _onEmojiSelected(emoji);
                  },
                  onBackspacePressed: _onBackspacePressed,
                  config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.deepPurpleAccent,
                      iconColor: Colors.black,
                      iconColorSelected: Colors.greenAccent,
                      progressIndicatorColor: Colors.pinkAccent,
                      backspaceColor: Colors.red,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.deepPurpleAccent,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      replaceEmojiOnLimitExceed: false,
                      noRecents: const Text(
                        'No Recents',
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                        textAlign: TextAlign.center,
                      ),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: const Card(
        margin: EdgeInsets.all(18.0),
      ),
    );
  }
}
