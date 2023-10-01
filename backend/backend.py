from flask import Flask, jsonify, request
import json
import random

import firebase_admin
from firebase_admin import credentials, storage
from firebase_admin import firestore

# Use a service account.
cred = credentials.Certificate('../serviceAccount/key.json')

app = firebase_admin.initialize_app(cred, {
    'storageBucket': 'pantry-pal-8faa1.appspot.com'  # Replace with your Firebase Storage bucket URL
})
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

@app.route('/upload-image', methods=['POST'])
def upload_image():
    try:
        # Get the uploaded image file
        image = request.files['image']

        if image:
            # Upload the image to Firebase Storage
            bucket = storage.bucket()
            blob = bucket.blob(f"images/{image.filename}")
            blob.upload_from_string(image.read(), content_type=image.content_type)

            # Get the public URL of the uploaded image
            image_url = blob.public_url

            # You can now save or use the image URL as needed
            return {'success': True, 'message': 'Image uploaded successfully', 'imageUrl': image_url}, 200
        else:
            return {'success': False, 'message': 'No image uploaded'}, 400
    except Exception as e:
        return {'success': False, 'message': str(e)}, 500


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
    foodID = request.args.get('foodID') #send foodID, using this route ('getFood?foodID=${foodID})
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

@app.post('/addItem')
def addItem():
    #userID = request.args.get('foodID')
    userID = "user01"
    form_data = request.get_json()
    foodID = randomID()

    users_ref = db.collection("userAccount").document("user01")
    food_ref = users_ref.collection("foods").document(foodID)
    
    data = {
        "name" : form_data.get('name'),
        "category" : form_data.get('category'),
        "expiryDate" : form_data.get('expiryDate'), 
        "qty" : form_data.get('qty'),
        "unit" : form_data.get('unit')
    }

    food_ref.set(data)

    response = {} 
    response['message'] = "success"
    response['code'] = 201
    return response

def randomID():
    random_id = random.randint(1, 9999)
    random_id = '{:04d}'.format(random_id)
    random_id_str = "food" + str(random_id)
    return random_id_str

@app.put('/updateItem/<foodID>') #url should look like '/updateItem/food01'
def update(foodID):
    #userID = request.args.get('userID')
    userID = "user01"
    form_data = request.get_json()

    users_ref = db.collection("userAccount").document(userID)
    food_ref = users_ref.collection("foods").document(foodID)
    
    data = {
        "name" : form_data.get('name'),
        "category" : form_data.get('category'),
        "expiryDate" : form_data.get('expiryDate'), 
        "qty" : form_data.get('qty'),
        "unit" : form_data.get('unit')
    }

    food_ref.update(data)

    response = {} 
    response['message'] = "success"
    response['code'] = 200
    return response

@app.delete('/delete/<foodID>') #url should look like '/delete/food01'
def delete(foodID):
    userID = "user01"
    users_ref = db.collection("userAccount").document(userID)
    food_ref = users_ref.collection("foods").document(foodID)

    food_ref.delete()

    response = {} 
    response['message'] = "success"
    response['code'] = 204
    return response
    
if __name__ == '__main__':
    app.run() #debug=True,  host='0.0.0.0', port=8080)