import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/utility/riverpod.dart';
import 'locationCard.dart';

class LocationListCustom extends ConsumerStatefulWidget {
  const LocationListCustom({super.key});

  @override
  ConsumerState<LocationListCustom> createState() => _LocationListCustomState();
}

class _LocationListCustomState extends ConsumerState<LocationListCustom>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List locations = ref.watch(locListProvider);
    final asyncList = ref.watch(fetchLoc);
    return Center(
      child: switch (asyncList) {
        AsyncData() => ListView.builder(
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == locations.length - 1) {
                ref.read(fetchLoc.notifier).nextPage();
                // print(a);
                if (ref.watch(fetchLoc.notifier).page!.info!.next != null) {
                  return const Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              }
              return ListCard(
                item: locations[index],
                type: 'location',
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
