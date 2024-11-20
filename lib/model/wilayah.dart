class Province {
  String? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Regency {
  String? id;
  String? provinceId;
  String? name;

  Regency({this.id, this.provinceId, this.name});

  Regency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'province_id': provinceId,
      'name': name,
    };
  }
}

class District {
  String? id;
  String? regencyId;
  String? name;

  District({this.id, this.regencyId, this.name});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regencyId = json['regency_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'regency_id': regencyId,
      'name': name,
    };
  }
}

class Village {
  String? id;
  String? districtId;
  String? name;

  Village({this.id, this.districtId, this.name});

  Village.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'district_id': districtId,
      'name': name,
    };
  }
}