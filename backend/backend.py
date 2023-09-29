from flask import Flask, jsonify, request

app = Flask(__name__)

@app.post('/register')
def register():
    data = request.get_json()
    name = data["name"]
    email = data["email"]
    pwd  = data["pwd"]
    return {"message": "Added", "code": 201, "data": data}, 201

if __name__ == '__main__':
    app.run()