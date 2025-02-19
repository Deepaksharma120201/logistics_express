class GetCoordinatesFromPlaceId {
  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  GetCoordinatesFromPlaceId({this.htmlAttributions, this.result, this.status});

  factory GetCoordinatesFromPlaceId.fromJson(Map<String, dynamic> json) {
    return GetCoordinatesFromPlaceId(
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (result != null) 'result': result!.toJson(),
      'status': status,
    };
  }
}

class Result {
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photos>? photos;
  String? placeId;
  String? reference;
  List<String>? types;
  String? url;
  int? utcOffset;

  Result({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.types,
    this.url,
    this.utcOffset,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      addressComponents: (json['address_components'] as List<dynamic>?)
          ?.map((v) => AddressComponents.fromJson(v))
          .toList(),
      adrAddress: json['adr_address'],
      formattedAddress: json['formatted_address'],
      geometry:
          json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null,
      icon: json['icon'],
      iconBackgroundColor: json['icon_background_color'],
      iconMaskBaseUri: json['icon_mask_base_uri'],
      name: json['name'],
      photos: (json['photos'] as List<dynamic>?)
          ?.map((v) => Photos.fromJson(v))
          .toList(),
      placeId: json['place_id'],
      reference: json['reference'],
      types: (json['types'] as List<dynamic>?)?.cast<String>(),
      url: json['url'],
      utcOffset: json['utc_offset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (addressComponents != null)
        'address_components':
            addressComponents!.map((v) => v.toJson()).toList(),
      'adr_address': adrAddress,
      'formatted_address': formattedAddress,
      if (geometry != null) 'geometry': geometry!.toJson(),
      'icon': icon,
      'icon_background_color': iconBackgroundColor,
      'icon_mask_base_uri': iconMaskBaseUri,
      'name': name,
      if (photos != null) 'photos': photos!.map((v) => v.toJson()).toList(),
      'place_id': placeId,
      'reference': reference,
      'types': types,
      'url': url,
      'utc_offset': utcOffset,
    };
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  factory AddressComponents.fromJson(Map<String, dynamic> json) {
    return AddressComponents(
      longName: json['long_name'],
      shortName: json['short_name'],
      types: (json['types'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long_name': longName,
      'short_name': shortName,
      'types': types,
    };
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      viewport:
          json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (location != null) 'location': location!.toJson(),
      if (viewport != null) 'viewport': viewport!.toJson(),
    };
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: json['northeast'] != null
          ? Location.fromJson(json['northeast'])
          : null,
      southwest: json['southwest'] != null
          ? Location.fromJson(json['southwest'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (northeast != null) 'northeast': northeast!.toJson(),
      if (southwest != null) 'southwest': southwest!.toJson(),
    };
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      height: json['height'],
      htmlAttributions:
          (json['html_attributions'] as List<dynamic>?)?.cast<String>(),
      photoReference: json['photo_reference'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'html_attributions': htmlAttributions,
      'photo_reference': photoReference,
      'width': width,
    };
  }
}
