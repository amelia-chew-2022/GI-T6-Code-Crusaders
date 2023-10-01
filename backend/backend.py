from flask import Flask, jsonify, request
import json

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use a service account.
cred = credentials.Certificate('../serviceAccount/key.json')

app = firebase_admin.initialize_app(cred)

db = firestore.client()

app = Flask(__name__)

#register users
@app.post('/register')
def register():
    data = request.get_json()
    name = data["name"]
    email = data["email"]
    pwd  = data["pwd"]
    return {"message": "Added", "code": 201, "data": data}, 201

# @app.get('/login')
# def checkLogin():
#     users_ref = db.collection("userAccount")
#     docs = users_ref.stream()
#     data = []
#     for doc in docs:
#         item = {
#             "user_id" : doc.id,
#             "name": doc.to_dict()
#         }
#         data.append(item)

#     return jsonify(data)


@app.get('/allFoodItem')
def get_food():
    users_ref = db.collection("userAccount").document("user01") #user need to be dynamic
    food_ref = users_ref.collection("foods")
    
    docs = food_ref.stream()
    response = {}
    data = []
    for document in docs:
        food = {
            "foodID" : document.id,
            "name" : document.get('name'),
            "category" : document.get('category'),
            "expiryDate" : document.get('expiryDate'), 
            "qty" : document.get('qty'),
            "unit" : document.get('unit')
        }
        data.append(food)

    response['data'] = data
    response['message'] = "success"
    response['code'] = 200
    
    return response

@app.get('/getFood')
def getFood():
    foodID = request.args.get('foodID') #send foodID
    users_ref = db.collection("userAccount").document("user01")
    food_ref = users_ref.collection("foods").document(foodID)
    document = food_ref.get()

    response = {}
    data = []

  

    food = {
            "foodID" : document.id,
            "name" : document.get('name'),
            "category" : document.get('category'),
            "expiryDate" : document.get('expiryDate'), 
            "qty" : document.get('qty'),
            "unit" : document.get('unit')
        }
    data.append(food)

    response['data'] = data
    response['message'] = "success"
    response['code'] = 200

    return response

if __name__ == '__main__':
    app.run() #debug=True,  host='0.0.0.0', port=8080)