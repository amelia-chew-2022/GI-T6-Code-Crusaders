import 'package:flutter/material.dart';

class Organisations extends StatelessWidget {
  final List<FoodWasteFacility> facilities = [
    FoodWasteFacility(
      name: '800 Super Waste Management Ptd Ltd',
      website: '',
      contactPerson: 'Ken Ong (Mr)',
      email: 'kenongke@800super.com.sg',
      contactNo: '6366 3800',
      acceptedWaste: 'Spent Grain, Soya Bean Waste (Okara)',
    ),
    FoodWasteFacility(
      name: 'A1 Environment Pte Ltd',
      website: 'https://a1environment.com.sg',
      contactPerson: 'Yen-Lyng (Ms)',
      email: 'yenlyng@a1environment.com.sg',
      contactNo: '8223 1977',
      acceptedWaste: 'Used coffee grounds',
    ),
    FoodWasteFacility(
      name: 'Bee Joo Industries Pte Ltd',
      website: 'www.ecowise.com.sg',
      contactPerson: 'Ajay (Mr)',
      email: 'ajay@ecowise.com.sg',
      contactNo: '6536 2489 / 9824 2763',
      acceptedWaste: 'Spent grains, soya bean waste, rejected milk powder, and bread waste',
    ),
    FoodWasteFacility(
      name: 'Chuan Huat Poultry Farm Pte Ltd',
      website: '',
      contactPerson: 'Ng Kong Guan (Mr)',
      email: 'kongguan@greentech.com.sg',
      contactNo: '6863 0332',
      acceptedWaste: 'Bread waste',
    ),
    FoodWasteFacility(
      name: 'Eng Cheong Leong Agri Chem Pte Ltd',
      website: '',
      contactPerson: 'Tay Tho Bok (Mr) / Kao Yu-Hui (Mr)',
      email: 'eclac@singnet.com.sg',
      contactNo: '6863 6118 / 6268 1185',
      acceptedWaste: 'Bread waste',
    ),
    FoodWasteFacility(
      name: 'Envcares Pte Ltd',
      website: 'www.envcares.com.sg',
      contactPerson: 'Ang Wei Xiong',
      email: 'weixiong@envcares.com.sg',
      contactNo: '9363 7873',
      acceptedWaste: 'Food manufacturer waste, flour, milk powder, soya waste, spent grain, dried food, canned food, rice, drink, premix food flavouring, fruits and vegetables and more',
    ),
    FoodWasteFacility(
      name: 'Lam Tak Pte Ltd',
      website: 'www.lamtak.com',
      contactPerson: 'Fiona Wong (Ms)',
      email: 'marketing@lamtak.com',
      contactNo: '6909 9337',
      acceptedWaste: 'Dried food waste, milk powder, other raw materials, by-products',
    ),
    FoodWasteFacility(
      name: 'Tiong Lam Supplies Pte Ltd',
      website: '',
      contactPerson: 'Samantha Sor (Ms) / Serene Teo (Ms)',
      email: 'enquiry@tionglam.com',
      contactNo: '9727 6083 / 9112 2085',
      acceptedWaste: 'Factory food waste, expired/spoilt food,off-specs food and pre-mixes, food by-products, excess food',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Food Waste Recycling Facilities in SG'),
      // ),
      body: ListView.builder(
        itemCount: facilities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(facilities[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Person: ${facilities[index].contactPerson}'),
                Text('Website: ${facilities[index].website}'),
                Text('Email: ${facilities[index].email}'),
                Text('Contact No.: ${facilities[index].contactNo}'),
                Text('Accepted Food Waste: ${facilities[index].acceptedWaste}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FoodWasteFacility {
  final String name;
  final String website;
  final String contactPerson;
  final String email;
  final String contactNo;
  final String acceptedWaste;

  FoodWasteFacility({
    required this.name,
    required this.website,
    required this.contactPerson,
    required this.email,
    required this.contactNo,
    required this.acceptedWaste,
  });
}
