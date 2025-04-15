import '/core/constant/app_assets.dart';

class DoctorModel {
  final String name;
  final String? uid;
  final double price;
  final String description;
  final String country;
  final String state;
  final String city;
  final String specialist;
  final String phoneNumber;
  double? rate;
  final double? lat;
  final double? long;
  final String street;
  final String area;

  final String imagePath;
  final DateTime createdAt;
  bool isInTheClinic;
  String? imageUrl;
  String workingFrom;

  String workingTo;

  String certificateUrl;

  bool isVerified;

  DoctorModel({
    this.isVerified = false,
    this.uid,
    required this.workingFrom,
    required this.workingTo,
    required this.certificateUrl,
    required this.imageUrl,
    required this.area,
    required this.street,
    required this.name,
    required this.price,
    required this.description,
    required this.country,
    required this.state,
    required this.city,
    required this.specialist,
    required this.phoneNumber,
    this.rate,
    this.lat,
    this.long,
    String? imagePath, // Made imagePath nullable for customization
    DateTime? createdAt, // Allowed createdAt to be passed during initialization
    this.isInTheClinic = false,
  })  : imagePath = imagePath ?? AppAssets.doctorAvatar,
        // Default value if null
        createdAt = createdAt ?? DateTime.now(); // Default value if null

  // Factory constructor for deserializing from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      isVerified: json['isVerified'],
      workingFrom: json['workingFrom'],
      workingTo: json['workingTo'],
      certificateUrl: json['certificateUrl'],
      imageUrl: json['imageUrl'],
      area: json['area'],
      street: json['street'],
      uid: json['uid'],
      name: json['name'] ?? 'Unknown Doctor',
      // Default value if missing
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      // Safe conversion to double
      description: json['description'] ?? 'No description available',
      country: json['country'] ?? 'Unknown Country',
      state: json['state'] ?? 'Unknown State',
      city: json['city'] ?? 'Unknown City',
      specialist: json['specialist'] ?? 'General Practitioner',
      phoneNumber: json['phoneNumber'] ?? 'N/A',
      rate: (json['rate'] as num?)?.toDouble(),
      // Safe conversion to double
      lat: (json['lat'] as num?)?.toDouble(),
      // Safe conversion to double
      long: (json['long'] as num?)?.toDouble(),
      // Safe conversion to double
      imagePath: json['imagePath'],
      // Assign directly (nullable)
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt']) // Parse from JSON
          : null,
      // Use default if not provided
      isInTheClinic: json['isInTheClinic'] ?? false, // Default to false if null
    );
  }

  // Method for serializing to JSON
  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
      'workingFrom': workingFrom,
      'workingTo': workingTo,
      'certificateUrl': certificateUrl,
      'imageUrl': imageUrl,
      'area': area,
      'street': street,
      'uid': uid,
      'name': name,
      'price': price,
      'description': description,
      'country': country,
      'state': state,
      'city': city,
      'specialist': specialist,
      'phoneNumber': phoneNumber,
      'rate': rate,
      'lat': lat,
      'long': long,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
      // Serialize DateTime as ISO string
      'isInTheClinic': isInTheClinic,
    };
  }
}
