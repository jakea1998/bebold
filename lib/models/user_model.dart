import 'package:be_bold/utils/enum_to_string.dart';

enum UserStatus { accepted, witnessed, na }

class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? notes;
  bool? subscribeToNewsletter;
  UserStatus? userStatus;
  DateTime? creationDate;
  UserModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.zipcode,
      this.notes,
      this.subscribeToNewsletter,
      this.userStatus,
      this.creationDate});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId != null ? this.userId : null;
    data['firstName'] = this.firstName != null ? this.firstName : null;
    data['lastName'] = this.lastName != null ? this.lastName : null;
    data['email'] = this.email != null ? this.email : null;
    data['phone'] = this.phone != null ? this.phone : null;
    data['address'] = this.address != null ? this.address : null;
    data['city'] = this.city != null ? this.city : null;
    data['state'] = this.state != null ? this.state : null;
    data['zipcode'] = this.zipcode != null ? this.zipcode : null;
    data['notes'] = this.notes != null ? this.notes : null;
    data['subscribeToNewsletter'] =
        this.subscribeToNewsletter != null ? this.subscribeToNewsletter : false;
    data['userStatus'] = this.userStatus != null
        ? EnumToString.convertToString(this.userStatus)
        : "na";
    data['creationDate'] =
        this.creationDate != null ? this.creationDate?.toIso8601String() : null;
    return data;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? json['userId'] : null;
    firstName = json['firstName'] != null ? json['firstName'] : null;
    lastName = json['lastName'] != null ? json['lastName'] : null;
    email = json['email'] != null ? json['email'] : null;
    phone = json['phone'] != null ? json['phone'] : null;
    address = json['address'] != null ? json['address'] : null;
    city = json['city'] != null ? json['city'] : null;
    state = json['state'] != null ? json['state'] : null;
    zipcode = json['zipcode'] != null ? json['zipcode'] : null;
    notes = json['notes'] != null ? json['notes'] : null;
    subscribeToNewsletter = json['subscribeToNewsletter'] != null
        ? json['subscribeToNewsletter']
        : null;
    userStatus = json['userStatus'] != null
        ? EnumToString.fromString(UserStatus.values, json["userStatus"])
        : UserStatus.na;
    creationDate = json['creationDate'] != null
        ? DateTime.tryParse(json['creationDate'])
        : DateTime.now();
  }
}
