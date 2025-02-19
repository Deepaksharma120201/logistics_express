class PlaceFromCoordinates {
  PlusCode? plusCode;
  List<Results>? results;
  String? status;

  PlaceFromCoordinates({this.plusCode, this.results, this.status});

  PlaceFromCoordinates.fromJson(Map<String, dynamic> json) {
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    if (json['results'] != null) {
      results =
          (json['results'] as List).map((v) => Results.fromJson(v)).toList();
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() => {
        'plus_code': plusCode?.toJson(),
        'results': results?.map((v) => v.toJson()).toList(),
        'status': status,
      };
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json)
      : compoundCode = json['compound_code'],
        globalCode = json['global_code'];

  Map<String, dynamic> toJson() => {
        'compound_code': compoundCode,
        'global_code': globalCode,
      };
}

class Results {
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  List<NavigationPoints>? navigationPoints;
  String? placeId;
  PlusCode? plusCode;
  List<String>? types;

  Results({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.navigationPoints,
    this.placeId,
    this.plusCode,
    this.types,
  });

  Results.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = (json['address_components'] as List)
          .map((v) => AddressComponents.fromJson(v))
          .toList();
    }
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    if (json['navigation_points'] != null) {
      navigationPoints = (json['navigation_points'] as List)
          .map((v) => NavigationPoints.fromJson(v))
          .toList();
    }
    placeId = json['place_id'];
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    types = json['types']?.cast<String>();
  }

  Map<String, dynamic> toJson() => {
        'address_components':
            addressComponents?.map((v) => v.toJson()).toList(),
        'formatted_address': formattedAddress,
        'geometry': geometry?.toJson(),
        'navigation_points': navigationPoints?.map((v) => v.toJson()).toList(),
        'place_id': placeId,
        'plus_code': plusCode?.toJson(),
        'types': types,
      };
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json)
      : longName = json['long_name'],
        shortName = json['short_name'],
        types = json['types']?.cast<String>();

  Map<String, dynamic> toJson() => {
        'long_name': longName,
        'short_name': shortName,
        'types': types,
      };
}

class Geometry {
  Location? location;
  String? locationType;
  Viewport? viewport;
  Viewport? bounds;

  Geometry({this.location, this.locationType, this.viewport, this.bounds});

  Geometry.fromJson(Map<String, dynamic> json)
      : location = json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        locationType = json['location_type'],
        viewport = json['viewport'] != null
            ? Viewport.fromJson(json['viewport'])
            : null,
        bounds =
            json['bounds'] != null ? Viewport.fromJson(json['bounds']) : null;

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'location_type': locationType,
        'viewport': viewport?.toJson(),
        'bounds': bounds?.toJson(),
      };
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json)
      : northeast = json['northeast'] != null
            ? Location.fromJson(json['northeast'])
            : null,
        southwest = json['southwest'] != null
            ? Location.fromJson(json['southwest'])
            : null;

  Map<String, dynamic> toJson() => {
        'northeast': northeast?.toJson(),
        'southwest': southwest?.toJson(),
      };
}

class NavigationPoints {
  Location? location;

  NavigationPoints({this.location});

  NavigationPoints.fromJson(Map<String, dynamic> json)
      : location = json['location'] != null
            ? Location.fromJson(json['location'])
            : null;

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
      };
}
