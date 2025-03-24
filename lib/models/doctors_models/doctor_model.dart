class DoctorModel {
  final String? name;
  final String? image;
  final double? price;
  final String? description;
  final String? location;
  final String? specialist;
  final String? phoneNumber;
  final double? rate;
  final double? lat;
  final double? long;
  final String? imagePath;
  bool isInTheClinic;

  DoctorModel({
    this.name,
    this.image,
    this.price,
    this.description,
    this.location,
    this.specialist,
    this.phoneNumber,
    this.rate,
    this.lat,
    this.long,
    this.imagePath,
    this.isInTheClinic = false,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
      location: json['location'],
      specialist: json['specialist'],
      phoneNumber: json['phoneNumber'],
      rate: json['rate'],
      lat: json['lat'],
      long: json['long'],
      imagePath: json['imagePath'],
      isInTheClinic: json['isInTheClinic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'location': location,
      'specialist': specialist,
      'phoneNumber': phoneNumber,
      'rate': rate,
      'lat': lat,
      'long': long,
      'imagePath': imagePath,
      'isInTheClinic': isInTheClinic,
    };
  }

  static List<DoctorModel> doctorsList() {
    final List<DoctorModel> doctors = [];

    final List<String> names = [
      'Dr. Ahmed Ali',
      'Dr. Fatma Mohamed',
      'Dr. Omar Hassan',
      'Dr. Aya Mahmoud',
      'Dr. Karim Samir',
      'Dr. Nourhan Youssef',
      'Dr. Tamer Farouk',
      'Dr. Salma Adel',
      'Dr. Hossam Gamal',
      'Dr. Dina Sameh',
      'Dr. Amr Abdelrahman',
      'Dr. Mariam Tarek',
      'Dr. Youssef Khaled',
      'Dr. Sara Ahmed',
      'Dr. Mostafa Ibrahim',
      'Dr. Reem Ali',
      'Dr. Mohamed Salah',
      'Dr. Layla Fawzy',
      'Dr. Kareem Nabil',
      'Dr. Menna Hany',
      'Dr. Mahmoud Sabry',
      'Dr. Yasmin Adly',
      'Dr. Hassan El-Sayed',
      'Dr. Rania Sherif',
      'Dr. Khaled Mansour',
      'Dr. Nada Ashraf',
      'Dr. Islam Hesham',
      'Dr. Shaimaa Magdy',
      'Dr. Wael Emad',
      'Dr. Heba Ahmed',
      'Dr. Ali Reda',
      'Dr. Nour El-Din',
      'Dr. Mona Sami',
      'Dr. Sameh Farid',
      'Dr. Zeinab Hassan',
      'Dr. Bassem Adel',
      'Dr. Laila Mohamed',
      'Dr. Ramy Khaled',
      'Dr. Safaa Mahmoud',
      'Dr. Eman Tarek',
      'Dr. Ahmed Fathy',
      'Dr. Ghada Samir',
      'Dr. Mohamed Gamal',
      'Dr. Amina Youssef',
      'Dr. Yassin Farouk',
      'Dr. Asmaa Adel',
      'Dr. Karim Gamal',
      'Dr. Noha Sameh',
      'Dr. Tarek Abdelrahman',
      'Dr. Nourhan Mohamed'
    ];

    final List<String> locations = [
      'Cairo',
      'Alexandria',
      'Giza',
      'Shubra El-Kheima',
      'Port Said',
      'Suez',
      'Luxor',
      'Asyut',
      'Mansoura',
      'Tanta',
      'Ismailia',
      'Fayoum',
      'Zagazig',
      'Damietta',
      'Aswan',
      'Minya',
      'Beni Suef',
      'Hurghada',
      'Qena',
      'Sohag',
      'Banha',
      'Damanhur',
      'El-Mahalla El-Kubra',
      'Kafr El-Sheikh',
      'Arish',
      'Marsa Matruh',
      'Siwa Oasis',
      'Abu Simbel',
      'Edfu',
      'Kom Ombo',
      'Dahab',
      'Nuweiba',
      'Al-Arish',
      'New Valley',
      'North Sinai',
      'South Sinai',
      'Red Sea Governorate',
      'Beheira',
      'Monufia',
      'Qalyubia',
      'Sharqia',
      'Gharbia',
      'Kafr El-Zayat',
      'Desouk',
      'Rosetta',
      'Bilbeis',
      'Samalut',
      'El-Qanater Charity',
      'Sadat City',
      '15th May City',
      'Obour City'
    ];

    final List<String> specialties = [
      'Cardiologist',
      'Dermatologist',
      'Pediatrician',
      'Neurologist',
      'Orthopedic Surgeon',
      'Gastroenterologist',
      'Psychiatrist',
      'Ophthalmologist',
      'ENT Specialist',
      'Endocrinologist',
      'Urologist',
      'Obstetrician',
      'Rheumatologist',
      'Pulmonologist',
      'Nephrologist',
      'Hematologist',
      'Radiologist',
      'Anesthesiologist',
      'Oncologist',
      'Allergist/Immunologist',
      'Infectious Disease Specialist'
    ];

    for (int i = 0; i < 50; i++) {
      doctors.add(
        DoctorModel(
          name: names[i % names.length],
          location: locations[i % locations.length],
          specialist: specialties[i % specialties.length],
          rate: (4.0 + (i / 50)).roundToDouble(),
          description: 'Experienced in treating various medical conditions.',
          phoneNumber: '123-456-789${(i + 1).toString().padLeft(2, '0')}',
          price: 100.0 + (i * 10),
          imagePath: 'assets/images/doctor_sample.jpg', // Fixed imagePath
        ),
      );
    }

    return doctors;
  }
}
