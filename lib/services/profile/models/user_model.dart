class UserModel {
  String name;
  String phone;
  DateTime birthday;
  String bio;
  String department;
  int id;

  UserModel({
    required this.name,
    required this.phone,
    required this.birthday,
    required this.department,
    required this.bio,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        phone: json["phone"],
        birthday: DateTime.parse(json["birthday"]),
    bio: json["bio"],
    department: json["department"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "department": department,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "sugar_type": bio,
        "id": id,
      };
}
