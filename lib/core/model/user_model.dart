class UserModel {
  int? id;
  String? name;
  String? uniqueId;
  String? carNumber;
  String? email;
  String? phone;
  String? userImage;
  String? latitude;
  String? longitude;
  int? isOnline;

  UserModel(
      {this.id,
      this.name,
      this.uniqueId,
      this.carNumber,
      this.email,
      this.phone,
      this.userImage,
      this.latitude,
      this.longitude,
      this.isOnline});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse("${json['id']}");
    name = json['name'];
    uniqueId = json['uniqueId'];
    carNumber = json['carNumber'];
    email = json['email'];
    phone = json['phone'];
    userImage = json['userImage'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isOnline = int.tryParse("${json['isOnline']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uniqueId'] = uniqueId;
    data['carNumber'] = carNumber;
    data['email'] = email;
    data['phone'] = phone;
    data['userImage'] = userImage;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isOnline'] = isOnline;
    return data;
  }
}
