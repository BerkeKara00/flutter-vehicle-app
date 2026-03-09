class VehicleModel {
  String? status;
  Meta? meta;
  List<Data>? data;

  VehicleModel({this.status, this.meta, this.data});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  String? title;
  String? description;
  String? source;
  String? generated;
  int? count;

  Meta({this.title, this.description, this.source, this.generated, this.count});

  Meta.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    source = json['source'];
    generated = json['generated'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['source'] = this.source;
    data['generated'] = this.generated;
    data['count'] = this.count;
    return data;
  }
}

class Data {
  int? id;
  String? make;
  String? model;
  int? year;
  int? price;
  String? currency;
  String? image;
  String? description;
  Specs? specs;

  Data(
      {this.id,
      this.make,
      this.model,
      this.year,
      this.price,
      this.currency,
      this.image,
      this.description,
      this.specs});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    price = json['price'];
    currency = json['currency'];
    image = json['image'];
    description = json['description'];
    specs = json['specs'] != null ? new Specs.fromJson(json['specs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.specs != null) {
      data['specs'] = this.specs!.toJson();
    }
    return data;
  }
}

class Specs {
  String? engine;
  String? transmission;
  String? fuelType;
  String? mileage;
  String? s060mph;
  String? horsepower;
  String? towing;

  Specs(
      {this.engine,
      this.transmission,
      this.fuelType,
      this.mileage,
      this.s060mph,
      this.horsepower,
      this.towing});

  Specs.fromJson(Map<String, dynamic> json) {
    engine = json['engine'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    mileage = json['mileage'];
    s060mph = json['0-60mph'];
    horsepower = json['horsepower'];
    towing = json['towing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['engine'] = this.engine;
    data['transmission'] = this.transmission;
    data['fuel_type'] = this.fuelType;
    data['mileage'] = this.mileage;
    data['0-60mph'] = this.s060mph;
    data['horsepower'] = this.horsepower;
    data['towing'] = this.towing;
    return data;
  }
}
