from flask import Flask, jsonify, request
import json

app = Flask(__name__)

@app.post('/register')
def register():
    data = request.get_json()
    name = data["name"]
    email = data["email"]
    pwd  = data["pwd"]
    return {"message": "Added", "code": 201, "data": data}, 201

@app.get('/allFoodItem')
def get_foodItems():
    response = {}
    response["data"] = [
                        {
                            "foodItem": "Bread",
                            "expiryDate": "2023-09-30",
                            "quantity": 2,
                            "units": "loaf",
                            "category": "Grains",
                            "id": 1
                        },
                         {
                            "foodItem": "Meji Milk",
                            "expiryDate": "2023-10-01",
                            "quantity": 500,
                            "units": "mililitres",
                            "category": "Milk Product",
                            "id": 2
                        },
                        {
                            "foodItem": "HL Milk",
                            "expiryDate": "2023-10-04",
                            "quantity": 500,
                            "units": "mililitres",
                            "category": "Milk Product",
                            "id": 2
                        }
                    ]
    response["message"] = "success"
    response["code"] = 200
    
    return response

if __name__ == '__main__':
    app.run()