
 # https://www.youtube.com/watch?v=JyJd111Ym7U&t=706s

from flask import Flask, request, jsonify
from pytube import extract

app = Flask(__name__)

@app.route('/receive_url', methods=['POST'])
def receive_url():
    url = request.json['url']
    # Process the URL as needed
    print("Received URL:", url)

    # Dummy data to send back to Flutter
    data = {'message': 'URL received successfully', 'processed_url': extract.video_id(url)}
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)
