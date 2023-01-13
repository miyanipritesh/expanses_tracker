class UserDetails {
  String? name;
  String? email;
  String? password;
  String? uid;
  String? id;
  String? type;
  String? photoUrl;

  UserDetails(
      {this.name,
      this.password,
      this.type,
      this.email,
      this.photoUrl,
      this.uid,
      this.id});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        id: json["id"],
        type: json["type"],
        uid: json["uId"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "id": id,
        "type": type,
        "uId": uid,
        "photoUrl": photoUrl,
      };
}
