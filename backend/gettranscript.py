from youtube_transcript_api import YouTubeTranscriptApi
from pytube import extract
import json
    

url = "https://www.youtube.com/watch?v=JyJd111Ym7U&t=706s"
id = extract.video_id(url)
print("id: " + id)

transcript = YouTubeTranscriptApi.get_transcript(id)
with open('transcript.json', 'w') as f:
    json.dump(transcript, f)
print(transcript)




import json
# Initialize an empty list to store the text
text_list = []

# Open the JSON file and load the data
with open('transcript.json', 'r') as f:
    data = json.load(f)

# Iterate over the list of dictionaries
for item in data:
    # Append the 'text' from each dictionary to the list
    text_list.append(item['text'])

# Join the list into a single string with spaces between each item
text = ' '.join(text_list)

with open('text.txt', 'w') as f:
    f.write(text)


print(text)
print("file created")