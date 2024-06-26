import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  ScrollController controller = ScrollController();
  late String _errorMessage = "";
  bool isSuccess = false;
  late String videoId;
  late String transcript;
  late String textData;

  Future<void> getvideoID(String link) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/getvideodata'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'url': link}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      videoId = data['videoId'];
      transcript = data['transcript'];
      textData = data['textData'];

      print("URL sent successfully");
      print(videoId);
    } else {
      print("Failed to send URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double inputfieldWidth = MediaQuery.of(context).size.width * .6;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: screenheight * .1,
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenheight * .2,
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
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _errorMessage = "";
                            String link = _textEditingController.text.trim();
                            final bool isValidUrl = Uri.parse(link).isAbsolute;

                            if (link.isEmpty) {
                              _errorMessage = 'Please enter some text';
                            } else if (!isValidUrl) {
                              _errorMessage = "Enter a valid URL";
                            } else if (link.length < 3) {
                              _errorMessage =
                                  'Text must be at least 3 characters long';
                            } else {
                              getvideoID(link);
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
                        ? Text("Youtube Video ID: $videoId")
                        : const Text(""),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isSuccess)
                  SizedBox(
                    height: screenheight * .5,
                    width: MediaQuery.of(context).size.width * .5,
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: videoId,
                        flags: const YoutubePlayerFlags(
                          autoPlay: true,
                          mute: true,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                //  Text(textData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
