class Estimate {
  String id;
  Start start;
  Start end;
  List<Records> records;
  int duration;
  int distance;
  Rules rules;
  MultiModal multiModal;

  Estimate(
      {this.id,
      this.start,
      this.end,
      this.records,
      this.duration,
      this.distance,
      this.rules,
      this.multiModal});

  Estimate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'] != null ? new Start.fromJson(json['start']) : null;
    end = json['end'] != null ? new Start.fromJson(json['end']) : null;
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
    duration = json['duration'];
    distance = json['distance'];
    rules = json['rules'] != null ? new Rules.fromJson(json['rules']) : null;
    multiModal = json['multiModal'] != null
        ? new MultiModal.fromJson(json['multiModal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.start != null) {
      data['start'] = this.start.toJson();
    }
    if (this.end != null) {
      data['end'] = this.end.toJson();
    }
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    if (this.rules != null) {
      data['rules'] = this.rules.toJson();
    }
    if (this.multiModal != null) {
      data['multiModal'] = this.multiModal.toJson();
    }
    return data;
  }
}

class Start {
  double lat;
  double lng;
  String address;
  String district;
  String city;
  String state;
  String zipcode;

  Start(
      {this.lat,
      this.lng,
      this.address,
      this.district,
      this.city,
      this.state,
      this.zipcode});

  Start.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    return data;
  }
}

class Records {
  int id;
  String name;
  Modality modality;
  int waitingTime;
  String price;
  int uuid;
  String alertMessage;
  double index;
  String urlLogo;
  String urlLojaAndroid;
  String urlLojaIos;
  String url;
  String urlAndroid;
  Rules rules;

  Records({
    this.id,
    this.name,
    this.modality,
    this.waitingTime,
    this.price,
    this.uuid,
    this.alertMessage,
    this.index,
    this.urlLogo,
    this.urlLojaAndroid,
    this.urlLojaIos,
    this.url,
    this.urlAndroid,
    this.rules,
  });

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    modality = json['modality'] != null
        ? new Modality.fromJson(json['modality'])
        : null;
    waitingTime = json['waiting_time'];
    price = json['price'];
    uuid = json['uuid'];
    alertMessage = json['alert_message'];
    index = json['index'].runtimeType == int
        ? json['index'].toDouble()
        : json['index'];
    urlLogo = json['url_logo'];
    urlLojaAndroid = json['url_loja_android'];
    urlLojaIos = json['url_loja_ios'];
    url = json['url'];
    urlAndroid = json['url_android'];
    rules = json['rules'] != null ? new Rules.fromJson(json['rules']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.modality != null) {
      data['modality'] = this.modality.toJson();
    }
    data['waiting_time'] = this.waitingTime;
    data['price'] = this.price;
    data['uuid'] = this.uuid;
    data['alert_message'] = this.alertMessage;
    data['index'] = this.index;
    data['url_logo'] = this.urlLogo;
    data['url_loja_android'] = this.urlLojaAndroid;
    data['url_loja_ios'] = this.urlLojaIos;
    data['url'] = this.url;
    data['url_android'] = this.urlAndroid;
    if (this.rules != null) {
      data['rules'] = this.rules.toJson();
    }
    return data;
  }
}

class Modality {
  String id;
  String name;
  double priceKm;
  int timeKm;
  int active;
  String keyApi;
  String nameApi;

  Modality(
      {this.id,
      this.name,
      this.priceKm,
      this.timeKm,
      this.active,
      this.keyApi,
      this.nameApi});

  Modality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priceKm = json['price_km'];
    timeKm = json['time_km'];
    active = json['active'];
    keyApi = json['key_api'];
    nameApi = json['name_api'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price_km'] = this.priceKm;
    data['time_km'] = this.timeKm;
    data['active'] = this.active;
    data['key_api'] = this.keyApi;
    data['name_api'] = this.nameApi;
    return data;
  }
}

class Rules {
  bool rideEnabled;
  bool rideSplit;
  bool changeCdc;
  bool pinEnabled;
  bool projectEnabled;
  bool justificationRequired;
  bool priceVisible;
  bool buttonEnabled;

  Rules(
      {this.rideEnabled,
      this.rideSplit,
      this.changeCdc,
      this.pinEnabled,
      this.projectEnabled,
      this.justificationRequired,
      this.priceVisible,
      this.buttonEnabled});

  Rules.fromJson(Map<String, dynamic> json) {
    rideEnabled = json['rideEnabled'];
    rideSplit = json['rideSplit'];
    changeCdc = json['changeCdc'];
    pinEnabled = json['pinEnabled'];
    projectEnabled = json['projectEnabled'];
    justificationRequired = json['justificationRequired'];
    priceVisible = json['priceVisible'];
    buttonEnabled = json['buttonEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rideEnabled'] = this.rideEnabled;
    data['rideSplit'] = this.rideSplit;
    data['changeCdc'] = this.changeCdc;
    data['pinEnabled'] = this.pinEnabled;
    data['projectEnabled'] = this.projectEnabled;
    data['justificationRequired'] = this.justificationRequired;
    data['priceVisible'] = this.priceVisible;
    data['buttonEnabled'] = this.buttonEnabled;
    return data;
  }
}

class MultiModal {
  bool isAvailable;
  String title;
  String message;

  MultiModal({this.isAvailable, this.title, this.message});

  MultiModal.fromJson(Map<String, dynamic> json) {
    isAvailable = json['isAvailable'];
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAvailable'] = this.isAvailable;
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}
