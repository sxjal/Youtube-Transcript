
 # https://www.youtube.com/watch?v=JyJd111Ym7U&t=706s

from flask import Flask, request, jsonify
from pytube import extract
from flask_cors import CORS 
from youtube_transcript_api import YouTubeTranscriptApi
from pytube import extract
import json

app = Flask(__name__)
CORS(app)

@app.route('/getvideodata', methods=['POST'])
def getvideodata():
	url = request.json['url']
	id = extract.video_id(url)
	transcript = YouTubeTranscriptApi.get_transcript(id)
	# print(transcript)
	text_list = []
	with open('transcript.json', 'r') as f:
		data = json.load(f)

	for item in data:
		text_list.append(item['text'])

	text = ' '.join(text_list)
	print("sending data.")
	data = {'videoId': id, 'transcript': transcript, 'textData': text}
	return jsonify(data)


if __name__ == '__main__':
    app.run(debug=True)
