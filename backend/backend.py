from flask import Flask, jsonify, request
import json
import random
from datetime import datetime, date, timedelta
from google.cloud import firestore

import firebase_admin
from firebase_admin import credentials, storage
from firebase_admin import firestore
from flask_cors import CORS


# Use a service account.
cred = credentials.Certificate('../serviceAccount/key.json')

app = firebase_admin.initialize_app(cred, {
    'storageBucket': 'pantry-pal-8faa1.appspot.com'  # Replace with your Firebase Storage bucket URL
})
db = firestore.client()

app = Flask(__name__)
CORS(app)

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

@app.route('/addItem', methods=['POST'])
def addItem():
    try:
        # Extract data from the request
        form_data = request.form.to_dict()
        name = form_data.get('name')
        category = form_data.get('category')
        expiryDate = form_data.get('expiryDate')
        qty = int(form_data.get('qty'))
        unit = form_data.get('unit')

        # Generate a random food ID
        foodID = randomID()

        # Upload the image to Firebase Storage
        image = request.files.get('image')
        if image:
            image_filename = f"{foodID}.jpg"
            bucket = storage.bucket()
            blob = bucket.blob(image_filename)
            blob.upload_from_file(image)

            # Get the public URL of the uploaded image
            image_url = blob.public_url
        else:
            image_filename = None

        # Post the data to Firestore
        users_ref = db.collection("userAccount").document("user01")
        food_ref = users_ref.collection("foods").document(foodID)

        data = {
            "name": name,
            "category": category,
            "expiryDate": expiryDate,
            "qty": qty,
            "unit": unit,
            "image_url": image_filename  # Add the image URL to the data
        }

        food_ref.set(data)

        response = {
            'message': "success",
            'code': 201
        }
        return jsonify(response), 201
    except Exception as e:
        print(e)
        response = {
            'success': False,
            'message': str(e)
        }
        return jsonify(response), 500

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

# Function to get image URL for a given foodID
def get_image_url(food_id):
    try:
        image_filename = f"{food_id}.jpg"
        bucket = storage.bucket()
        blob = bucket.blob(image_filename)  # Adjust the path as needed
        return blob.generate_signed_url(expiration=3600)  # Expiration time in seconds
    except Exception as e:
        print(f"Error retrieving image URL for foodID {food_id}: {str(e)}")
        return None

@app.get('/allFoodItem')
def get_food():
    users_ref = db.collection("userAccount").document("user01") #user need to be dynamic
    food_ref = users_ref.collection("foods")
    
    try: 
        docs = food_ref.stream()
        response = {}
        data = []
        for document in docs:
            food = {
                "foodID" : document.id,
                "name" : document.get('name'),
                "category" : document.get('category'),
                "expiryDate" : document.get('expiryDate'), 
                "qty" : int(document.get('qty')),
                "unit" : document.get('unit'),
                "imageURL": document.get('image_url')
            }
            #image_url = get_image_url(document.id)
            #food["imageURL"] = image_url
            data.append(food)

        response['data'] = data
        response['message'] = "success"
        response['code'] = 200
        
        return response
    except Exception as e:
        print("Exception:", e)

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
        "qty" : int(form_data.get('qty')),
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

@app.get('/filterByExpiry/<range>') #url should look like '/filterByExpiry/3' <range> => 3 : next 3 days
def filterByExpiry(range):
    userID = "user01"
    users_ref = db.collection("userAccount").document(userID)
    food_ref = users_ref.collection("foods")
    docs = food_ref.stream()
    response = {}
    data = []
    current_date = date.today() #1 oct
    range = int(range)
    for document in docs:
        date_str = document.get('expiryDate')
        expiry = datetime.strptime(date_str, '%Y-%m-%d').date()
        future_date = current_date + timedelta(days=range)
        if (expiry <= future_date):
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

@app.get('/filterByCategory/<category>') #url should look like '/filterByCategory/Snack'
def filterByCategory(category):
    userID = "user01"
    users_ref = db.collection("userAccount").document(userID)
    food_ref = users_ref.collection("foods")
    docs = food_ref.stream()
    response = {}
    data = []

    for document in docs:
        if (document.get('category') == category):
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

@app.get('/sortByExpiry/<sort>')  #url should look like '/sortByExpiry/ASC' or '/sortByExpiry/DESC'
def sortByExpiry(sort):
    userID = "user01"
    users_ref = db.collection("userAccount").document(userID)
    if (sort == "DESC"):
        query = users_ref.collection("foods").order_by("expiryDate", direction=firestore.Query.DESCENDING)
    elif (sort == "ASC"):
        query = users_ref.collection("foods").order_by("expiryDate", direction=firestore.Query.ASCENDING)

    results = query.get()
    data = []
    response = {}
    for document in results:
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

@app.get('/sortByAtoZ/<sort>') #url should look like '/sortByAtoZ/ASC' or '/sortByAtoZ/DESC'
def sortByAtoZ(sort):
    userID = "user01"
    users_ref = db.collection("userAccount").document(userID)
    if (sort == "DESC"):
        query = users_ref.collection("foods").order_by("name", direction=firestore.Query.DESCENDING)
    elif (sort == "ASC"):
        query = users_ref.collection("foods").order_by("name", direction=firestore.Query.ASCENDING)

    results = query.get()
    data = []
    response = {}
    for document in results:
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

@app.get('/categoryDDL')
def getCategoryDDL():
    category = db.collection("category").stream()
    data = []
    response = {}
    print(category)
    for document in category:
        data.append(document.get('name'))

    response['data'] = data
    response['message'] = "success"
    response['code'] = 200
    return response

if __name__ == '__main__':
    app.run() #debug=True,  host='0.0.0.0', port=8080)