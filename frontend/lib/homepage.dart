import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  ScrollController controller = ScrollController();
  late String _errorMessage = "";
  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double inputfieldWidth = MediaQuery.of(context).size.width * .6;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          controller: controller,
          child: Container(
            padding: EdgeInsets.only(
              left: screenheight * .1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenheight * .4,
                ),
                const Text(
                  "Youtube video transcript, detailed notes and summarizer",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(
                  height: screenheight * .05,
                ),
                Container(
                  width: inputfieldWidth,
                  child: TextField(
                    enabled: !isSuccess,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'Enter video URL',
                      border: const OutlineInputBorder(),
                      errorText: _errorMessage,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _errorMessage = "";
                            String inputText =
                                _textEditingController.text.trim();
                            final bool isValidUrl =
                                Uri.parse(inputText).isAbsolute;

                            if (inputText.isEmpty) {
                              _errorMessage = 'Please enter some text';
                            } else if (!isValidUrl) {
                              _errorMessage = "Enter a valid URL";
                            } else if (inputText.length < 3) {
                              _errorMessage =
                                  'Text must be at least 3 characters long';
                            } else {
                              isSuccess = true;
                            }
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Set the color of the border
                            width: 2, // Set the width of the border
                          ),
                        ),
                        child: !isSuccess
                            ? const Text("Summarize Video")
                            : const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    isSuccess
                        ? const Text("Youtube Video ID: ")
                        : const Text(""),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 500,
                  width: 600,
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId:
                          'K18cpp_-gP8', // Replace with the ID of your YouTube video
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
