class PlaceFromCoordinates {
  PlusCode? plusCode;
  List<Results>? results;
  String? status;

  PlaceFromCoordinates({this.plusCode, this.results, this.status});

  PlaceFromCoordinates.fromJson(Map<String, dynamic> json) {
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

class Results {
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  List<NavigationPoints>? navigationPoints;
  String? placeId;
  PlusCode? plusCode;
  List<String>? types;

  Results(
      {this.addressComponents,
      this.formattedAddress,
      this.geometry,
      this.navigationPoints,
      this.placeId,
      this.plusCode,
      this.types});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(new AddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    if (json['navigation_points'] != null) {
      navigationPoints = <NavigationPoints>[];
      json['navigation_points'].forEach((v) {
        navigationPoints!.add(new NavigationPoints.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressComponents != null) {
      data['address_components'] =
          this.addressComponents!.map((v) => v.toJson()).toList();
    }
    data['formatted_address'] = this.formattedAddress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    if (this.navigationPoints != null) {
      data['navigation_points'] =
          this.navigationPoints!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode!.toJson();
    }
    data['types'] = this.types;
    return data;
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    data['types'] = this.types;
    return data;
  }
}

class Geometry {
  Location? location;
  String? locationType;
  Viewport? viewport;
  Viewport? bounds;

  Geometry({this.location, this.locationType, this.viewport, this.bounds});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
    bounds =
        json['bounds'] != null ? new Viewport.fromJson(json['bounds']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['location_type'] = this.locationType;
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    if (this.bounds != null) {
      data['bounds'] = this.bounds!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Location.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}

class NavigationPoints {
  Location? location;

  NavigationPoints({this.location});

  NavigationPoints.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}
