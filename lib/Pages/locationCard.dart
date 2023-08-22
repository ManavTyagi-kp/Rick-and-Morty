// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rickandmorty/utility/models.dart' as model;

import 'CharacterCard.dart';

class ListCard extends ConsumerWidget {
  final String type;
  final item;

  const ListCard({
    super.key,
    required this.type,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data;
    if (type == 'location') {
      data = model.Location.fromMap(item);
    } else {
      data = model.Episode.fromMap(item);
    }
    // print('inside location');
    return SizedBox(
      height: 300,
      child: Card(
        color: const Color.fromARGB(255, 33, 30, 92),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 400,
                child: Text(
                  data.name!,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                type == 'location'
                    ? '${data.type}  -  ${data.dimension}'
                    : '${data.episode}  -  ${data.air_date}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 170,
                  child: type == 'location'
                      ? ScrollCards(
                          type: 'Residents', residents: data.residents!)
                      : ScrollCards(
                          type: 'Characters', residents: data.characters!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
