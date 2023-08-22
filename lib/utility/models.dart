// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Page {
  final Info? info;
  final List results;
  Page({
    required this.info,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info?.toMap(),
      'results': results,
    };
  }

  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
      info: map['info'] != null
          ? Info.fromMap(map['info'] as Map<String, dynamic>)
          : null,
      results: List.from((map['results'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Page.fromJson(String source) =>
      Page.fromMap(json.decode(source) as Map<String, dynamic>);

  Page copyWith({
    Info? info,
    List? results,
  }) {
    return Page(
      info: info ?? this.info,
      results: results ?? this.results,
    );
  }

  @override
  String toString() => 'Page(info: $info, results: $results)';

  @override
  bool operator ==(covariant Page other) {
    if (identical(this, other)) return true;

    return other.info == info && listEquals(other.results, results);
  }

  @override
  int get hashCode => info.hashCode ^ results.hashCode;
}

class Info {
  final int? count;
  final int? pages;
  final String? next;
  final String? prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      count: map['count'] != null ? map['count'] as int : null,
      pages: map['pages'] != null ? map['pages'] as int : null,
      next: map['next'] != null ? map['next'] as String : null,
      prev: map['prev'] != null ? map['prev'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);
}

@immutable
class Character {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Origin? origin;
  final CharLocation? location;
  final String? image;
  final List? episode;
  final String? url;
  final String? created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  Character copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    Origin? origin,
    CharLocation? location,
    String? image,
    List? episode,
    String? url,
    String? created,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin?.toMap(),
      'location': location?.toMap(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      species: map['species'] != null ? map['species'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      origin: map['origin'] != null
          ? Origin.fromMap(map['origin'] as Map<String, dynamic>)
          : null,
      location: map['location'] != null
          ? CharLocation.fromMap(map['location'] as Map<String, dynamic>)
          : null,
      image: map['image'] != null ? map['image'] as String : null,
      episode: List.from((map['episode'] as List)),
      url: map['url'] != null ? map['url'] as String : null,
      created: map['created'] != null ? map['created'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Character(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, episode: $episode, url: $url, created: $created)';
  }

  @override
  bool operator ==(covariant Character other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.status == status &&
        other.species == species &&
        other.type == type &&
        other.gender == gender &&
        other.origin == origin &&
        other.location == location &&
        other.image == image &&
        listEquals(other.episode, episode) &&
        other.url == url &&
        other.created == created;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        status.hashCode ^
        species.hashCode ^
        type.hashCode ^
        gender.hashCode ^
        origin.hashCode ^
        location.hashCode ^
        image.hashCode ^
        episode.hashCode ^
        url.hashCode ^
        created.hashCode;
  }
}

class Origin {
  final String? name;
  final String? url;

  Origin({
    required this.name,
    required this.url,
  });

  Origin copyWith({
    String? name,
    String? url,
  }) {
    return Origin(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory Origin.fromMap(Map<String, dynamic> map) {
    return Origin(
      name: map['name'] != null ? map['name'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Origin.fromJson(String source) =>
      Origin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Origin(name: $name, url: $url)';

  @override
  bool operator ==(covariant Origin other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}

class CharLocation {
  final String? name;
  final String? url;

  CharLocation({
    this.name,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory CharLocation.fromMap(Map<String, dynamic> map) {
    return CharLocation(
      name: map['name'] != null ? map['name'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharLocation.fromJson(String source) =>
      CharLocation.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Location {
  final int? id;
  final String? name;
  final String? type;
  final String? dimension;
  final List? residents;
  final String? url;
  final String? created;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'dimension': dimension,
      'residents': residents,
      'url': url,
      'created': created,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      dimension: map['dimension'] as String,
      residents: List.from((map['residents'] as List)),
      url: map['url'] as String,
      created: map['created'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Episode {
  final int? id;
  final String? name;
  final String? air_date;
  final String? episode;
  final List? characters;
  final String? url;
  final String? created;

  Episode({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'air_date': air_date,
      'episode': episode,
      'characters': characters,
      'url': url,
      'created': created,
    };
  }

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      air_date: map['air_date'] != null ? map['air_date'] as String : null,
      episode: map['episode'] != null ? map['episode'] as String : null,
      characters: List.from((map['characters'] as List)),
      url: map['url'] != null ? map['url'] as String : null,
      created: map['created'] != null ? map['created'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Episode.fromJson(String source) =>
      Episode.fromMap(json.decode(source) as Map<String, dynamic>);
}
