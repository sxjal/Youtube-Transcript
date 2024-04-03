
 # https://www.youtube.com/watch?v=JyJd111Ym7U&t=706s

from flask import Flask, request, jsonify
from pytube import extract
from flask_cors import CORS 
from youtube_transcript_api import YouTubeTranscriptApi
from pytube import extract
import json

app = Flask(__name__)
CORS(app)

@app.route('/getvideoid', methods=['POST'])
def getvideoid():
    url = request.json['url']
    # Process the URL as needed
    print("Received URL:", url)

    # Dummy data to send back to Flutter
    data = {'message': 'URL received successfully', 'processed_url': extract.video_id(url)}
    return jsonify(data)



@app.route('/gettranscripts', methods=['POST'])
def gettranscripts():
	id = request.json['id']

	print("video id: ",id)
	transcript = YouTubeTranscriptApi.get_transcript(id)
	print(transcript)

	text_list = []
	with open('transcript.json', 'r') as f:
		data = json.load(f)

	for item in data:
		text_list.append(item['text'])

	text = ' '.join(text_list)

 
	data = {'message': 'URL received successfully', 'transcript': transcript, 'textdata':text}
	return jsonify(data)


if __name__ == '__main__':
    app.run(debug=True)
