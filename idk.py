from flask import request, Flask
import json

app = Flask(__name__)

@app.route('/addVeg', methods=['POST'])
def veg():
    with open("i.json", "w") as js:
        json.dump(request.data.decode('utf-8'), js)
    return 'Veg added'