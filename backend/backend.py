from flask import Flask, jsonify, request

app = Flask(__name__)

@app.post('/register')
def register():
    try:
        data = request.get_json()
        name = data["name"]
        email = data["email"]
        pwd = data["pwd"]
        
        # Perform data validation and user registration logic here
        
        return {"message": "User added successfully", "code": 201, "data": data}, 201
    except Exception as e:
        return {"message": "Error: " + str(e), "code": 500}

@app.get('/allFoodItem')
def get_foodItems():
    # Replace this mock data with actual data retrieval logic from your data source
    response = {
        "data": [
            {
                "foodItem": "Bread",
                "expiryDate": "2023-09-30",
                "quantity": 2,
                "units": "loaf",
                "category": "Grains",
                "id": 1
            },
            # ... (other food items)
        ],
        "message": "Success",
        "code": 200
    }
    
    return response

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
