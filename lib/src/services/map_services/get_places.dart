class GetPlaces {
  List<Predictions> predictions;
  String? status;

  GetPlaces({this.predictions = const [], this.status});

  factory GetPlaces.fromJson(Map<String, dynamic> json) {
    return GetPlaces(
      predictions: (json['predictions'] as List<dynamic>?)
              ?.map((v) => Predictions.fromJson(v))
              .toList() ??
          [],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predictions': predictions.map((v) => v.toJson()).toList(),
      'status': status,
    };
  }
}

class Predictions {
  String? description;
  List<MatchedSubstrings> matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Terms> terms;
  List<String>? types;

  Predictions({
    this.description,
    this.matchedSubstrings = const [],
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms = const [],
    this.types,
  });

  factory Predictions.fromJson(Map<String, dynamic> json) {
    return Predictions(
      description: json['description'],
      matchedSubstrings: (json['matched_substrings'] as List<dynamic>?)
              ?.map((v) => MatchedSubstrings.fromJson(v))
              .toList() ??
          [],
      placeId: json['place_id'],
      reference: json['reference'],
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
      terms: (json['terms'] as List<dynamic>?)
              ?.map((v) => Terms.fromJson(v))
              .toList() ??
          [],
      types: (json['types'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'matched_substrings': matchedSubstrings.map((v) => v.toJson()).toList(),
      'place_id': placeId,
      'reference': reference,
      'structured_formatting': structuredFormatting?.toJson(),
      'terms': terms.map((v) => v.toJson()).toList(),
      'types': types,
    };
  }
}

class MatchedSubstrings {
  int? length;
  int? offset;

  MatchedSubstrings({this.length, this.offset});

  factory MatchedSubstrings.fromJson(Map<String, dynamic> json) {
    return MatchedSubstrings(
      length: json['length'],
      offset: json['offset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'offset': offset,
    };
  }
}

class StructuredFormatting {
  String? mainText;
  String? secondaryText;

  StructuredFormatting({this.mainText, this.secondaryText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'],
      secondaryText: json['secondary_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main_text': mainText,
      'secondary_text': secondaryText,
    };
  }
}

class Terms {
  int? offset;
  String? value;

  Terms({this.offset, this.value});

  factory Terms.fromJson(Map<String, dynamic> json) {
    return Terms(
      offset: json['offset'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offset': offset,
      'value': value,
    };
  }
}
