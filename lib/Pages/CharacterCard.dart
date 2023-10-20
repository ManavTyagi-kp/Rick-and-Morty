import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utility/models.dart';
import '../utility/riverpod.dart';

class CharacterCard extends ConsumerWidget {
  final Character data;
  const CharacterCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceWidth = mediaQueryData.size.height;
    // print('inside character');
    return SizedBox(
      height: 250,
      width: deviceWidth - 10,
      child: Card(
        color: const Color.fromARGB(255, 14, 43, 81),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          // avatar
          child: Center(
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    height: 200,
                    width: deviceWidth * (18 / 100),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 150,
                            width: deviceWidth * (20 / 100),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  child: Transform.rotate(
                                    angle: -0.8,
                                    child: const CircularProgressIndicator(
                                      color: Color.fromARGB(255, 247, 224, 24),
                                      value: 0.65,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(
                                    ((deviceWidth * (16 / 100)) - (75 * 2)) / 2,
                                    0,
                                  ),
                                  child: CircleAvatar(
                                    radius: 68,
                                    backgroundImage: NetworkImage(data.image!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: 200,
                        child: Text(
                          data.name!,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: data.status == 'Alive'
                                      ? const Color.fromARGB(255, 67, 145, 56)
                                          .withOpacity(0.4)
                                      : Colors.red.withOpacity(0.4),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.circle,
                              color: data.status == 'Alive'
                                  ? const Color.fromARGB(255, 67, 145, 56)
                                  : Colors.red,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${data.status}  -  ',
                            style: const TextStyle(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 70,
                            child: Text(
                              data.species!,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Last Known Location:',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: 200,
                        child: Text(
                          data.location!.name!,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'First seen in: ',
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollCards extends StatefulWidget {
  final List residents;
  final String? type;

  const ScrollCards({
    Key? key,
    required this.type,
    required this.residents,
  }) : super(key: key);

  @override
  State<ScrollCards> createState() => _ScrollCardsState();
}

class _ScrollCardsState extends State<ScrollCards> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceWidth = mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Center(
            child: Text(
              '${widget.type}: ',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              // print(widget.residents);
              return SizedBox(
                height: 130,
                child: PageView.builder(
                  itemCount: widget.residents.length,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return ref
                        .watch(characterProvider(widget.residents[i]))
                        .when(data: (data) {
                      // print('inside resident');
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.8,
                        child: Card(
                          color: const Color.fromARGB(255, 255, 243, 200),
                          shadowColor: const Color(0xA3030303),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 100,
                                    width: 90,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            height: 90,
                                            width: deviceWidth *
                                                (90 / deviceWidth),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Positioned.fill(
                                                  child: Transform.rotate(
                                                    angle: -0.8,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: Color.fromARGB(
                                                          255, 33, 30, 92),
                                                      value: 0.65,
                                                      strokeWidth: 2,
                                                    ),
                                                  ),
                                                ),
                                                Transform.translate(
                                                  // Calculate the offset based on progress indicator and CircleAvatar dimensions
                                                  offset: const Offset(
                                                    (150 - (74 * 2)) / 2,
                                                    0,
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            data.image!),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        width: 100,
                                        child: Text(
                                          data.name!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 33, 30, 92),
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines:
                                              2, // Set the maximum number of lines
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: data.status == 'Alive'
                                                      ? const Color.fromARGB(
                                                              255, 67, 145, 56)
                                                          .withOpacity(0.4)
                                                      : Colors.red
                                                          .withOpacity(0.4),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.circle,
                                              color: data.status == 'Alive'
                                                  ? const Color.fromARGB(
                                                      255, 67, 145, 56)
                                                  : Colors.red,
                                              size: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${data.status}',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 33, 30, 92)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: deviceWidth * 0.4,
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          '${data.species}',
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 33, 30, 92)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }, error: (error, stackTrace) {
                      return Center(
                        child: Text(error.toString()),
                      );
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
