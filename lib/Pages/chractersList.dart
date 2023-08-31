import 'package:flutter/material.dart';
import 'package:rickandmorty/utility/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/utility/riverpod.dart';

import 'CharacterCard.dart';

class CharacterListPod extends ConsumerStatefulWidget {
  const CharacterListPod({super.key});

  @override
  ConsumerState<CharacterListPod> createState() => _CharacterListPodState();
}

class _CharacterListPodState extends ConsumerState<CharacterListPod>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List characters = ref.watch(listProvider);
    final asyncList = ref.watch(fetchChar);
    return Center(
      child: switch (asyncList) {
        AsyncData() => ListView.builder(
            itemCount: characters.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == characters.length - 1) {
                ref.read(fetchChar.notifier).nextPage();
                // print(a);
                if (ref.watch(fetchChar.notifier).page!.info!.next != null) {
                  return const Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              }
              return CharacterCard(
                data: models.Character.fromMap(characters[index]),
              );
            },
          ),
        AsyncError(:final error) => Text('Error: $error'),
        AsyncValue() => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
