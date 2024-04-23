class MemberModel {
  dynamic id;
  dynamic memberName;
  dynamic memberId;
  dynamic memberEmail;
  dynamic memberNumber;
  dynamic memberTotal;
  dynamic referralCode;
  dynamic referralUrl;

  MemberModel(
      {this.id,
        this.memberName,
        this.memberId,
        this.memberEmail,
        this.memberNumber,
        this.memberTotal,
        this.referralCode,
        this.referralUrl});

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberName = json['member_name'];
    memberId = json['member_id'];
    memberEmail = json['member_email'];
    memberNumber = json['member_number'];
    memberTotal = json['member_total'];
    referralCode = json['referral_code'];
    referralUrl = json['referral_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['member_name'] = memberName;
    data['member_id'] = memberId;
    data['member_email'] = memberEmail;
    data['member_number'] = memberNumber;
    data['member_total'] = memberTotal;
    data['referral_code'] = referralCode;
    data['referral_url'] = referralUrl;
    return data;
  }
}
