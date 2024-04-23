class UserInfoModel {
  int? id;
  String? name;
  String? method;
  String? fName;
  String? lName;
  dynamic phone;
  String? image;
  String? email;
  String? referralCode;
  String? referralUrl;
  dynamic directMember;
  dynamic totalDirectMember;
  dynamic totalMember;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  dynamic walletBalance;
  double? loyaltyPoint;

  UserInfoModel(
      {this.id,
      this.name,
      this.method,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.referralCode,
      this.referralUrl,
      this.directMember,
      this.totalDirectMember,
      this. totalMember,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.walletBalance,
      this.loyaltyPoint});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    method = json['_method'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    referralCode = json['referral_code'];
    referralUrl = json['referral_url'];
    directMember = json['directMember'];
    totalDirectMember = json['total_direct_member'];
    totalMember = json['total_member'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['wallet_balance'] != null) {
      walletBalance = json['wallet_balance'].toDouble();
    }
    if (json['loyalty_point'] != null) {
      loyaltyPoint = json['loyalty_point'].toDouble();
    } else {
      walletBalance = 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_method'] = method;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    data['referral_code'] = referralCode;
    data['referral_url'] = referralUrl;
    data['directMember']= directMember;
    data['total_direct_member'] = totalDirectMember;
    data['total_member'] = totalMember;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wallet_balance'] = walletBalance;
    data['loyalty_point'] = loyaltyPoint;
    return data;
  }
}
