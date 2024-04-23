class TopSellerModel {
  int? _id;
  int? _sellerId;
  String? _name;
  String? _email;
  String? _phone;
  String? _address;
  String? _city;
  String? _state;
  String? _country;
  String? _zipCode;
  String? _contact;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _banner;
  int? _temporaryClose;
  String? _vacationEndDate;
  String? _vacationStartDate;
  int? _vacationStatus;

  TopSellerModel(
      {int? id,
        int? sellerId,
        String? name,
        String? email,
        String? phone,
        String? address,
        String? city,
        String? state,
        String? country,
        String? zipCode,
        String? contact,
        String? image,
        String? createdAt,
        String? updatedAt,
        String? banner,
        int? temporaryClose,
        String? vacationEndDate,
        String? vacationStartDate,
        int? vacationStatus
      }) {
    _id = id;
    _sellerId = sellerId;
    _name = name;
    _email = email;
    _phone = phone;
    _address = address;
    _city = city;
    _state = state;
    _country = country;
    _zipCode = zipCode;
    _contact = contact;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _banner = banner;
    _temporaryClose = temporaryClose;
    _vacationEndDate = vacationEndDate;
    _vacationStartDate = vacationStartDate;
    _vacationStatus = vacationStatus;
  }

  int? get id => _id;
  int? get sellerId => _sellerId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get zipCode => _zipCode;
  String? get contact => _contact;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get banner => _banner;
  int? get temporaryClose => _temporaryClose;
  String? get vacationEndDate => _vacationEndDate;
  String? get vacationStartDate => _vacationStartDate;
  int? get vacationStatus => _vacationStatus;

  TopSellerModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sellerId = json['seller_id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _country=json['country'];
    _zipCode= json['zipCode'];
    _contact = json['contact'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _banner = json['banner'];
    _temporaryClose = json['temporary_close'] != null? int.parse(json['temporary_close'].toString()):0;
    _vacationEndDate = json['vacation_end_date'];
    _vacationStartDate = json['vacation_start_date'];
    _vacationStatus = json['vacation_status'] != null? int.parse(json['vacation_status'].toString()):0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['seller_id'] = _sellerId;
    data['name'] = _name;
    data['email'] = _email;
    data['phone']= _phone;
    data['address'] = _address;
    data['city'] = _city;
    data['state'] = _state;
    data['country'] = _country;
    data['zipCode'] = _zipCode;
    data['contact'] = _contact;
    data['image'] = _image;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['banner'] = _banner;
    data['temporary_close'] = _temporaryClose;
    data['vacation_end_date'] = _vacationEndDate;
    data['vacation_start_date'] = _vacationStartDate;
    data['vacation_status'] = _vacationStatus;
    return data;
  }
}
