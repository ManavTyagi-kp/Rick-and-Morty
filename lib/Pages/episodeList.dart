import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/utility/riverpod.dart';
import 'locationCard.dart';

class EpisodeListPod extends ConsumerStatefulWidget {
  const EpisodeListPod({super.key});

  @override
  ConsumerState<EpisodeListPod> createState() => _EpisodeListPodState();
}

class _EpisodeListPodState extends ConsumerState<EpisodeListPod>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List episodes = ref.watch(episodeListProvider);
    final asyncList = ref.watch(fetchEpisode);
    return Center(
      child: switch (asyncList) {
        AsyncData() => ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == episodes.length - 1) {
                ref.read(fetchEpisode.notifier).nextPage();
                // print(a);
                if (ref.watch(fetchEpisode.notifier).page!.info!.next != null) {
                  return const Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              }
              return ListCard(
                item: episodes[index],
                type: 'episode',
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
