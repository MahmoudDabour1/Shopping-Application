class UserDataModel {
  String? name;
  String ?email;
  String? mobileNo;
  String? uId;
  String? image;

  UserDataModel({
    this.name,
    this.email,
    this.mobileNo,
    this.uId,
    this.image,
  });


  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json["name"],
      email: json["email"],
      mobileNo: json["mobileNo"],
      uId: json["uId"],
      image: json["image"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email":email,
      "mobileNo":mobileNo,
      "uId":uId,
      "image": image,
    };
  }
}
