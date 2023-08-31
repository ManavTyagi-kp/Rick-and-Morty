import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Pages/bottomNav.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 3, 35, 76)),
        useMaterial3: true,
      ),
      home: const BottomNav(),
    );
  }
}

// class MyHomePage extends ConsumerWidget {
//   final String url;
//   final String type;
//   const MyHomePage({
//     Key? key,
//     required this.url,
//     required this.type,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rick and Morty App'),
//       ),
//       body: ref.watch(fetchCharacter(url)).when(
//         data: (data) {
//           print('Built');
//           return ListView(
//             children: [
//               for (int i = 0; i < data.results.length; i++)
//                 type == 'character'
//                     ? MyCard(
//                         data: Character.fromMap(
//                           data.results[i],
//                         ),
//                       )
//                     : type == 'location'
//                         ? MyLocationCard(
//                             data: MyLocation.fromMap(
//                               data.results[i],
//                             ),
//                           )
//                         : MyEpisodeCard(
//                             data: MyEpisode.fromMap(
//                               data.results[i],
//                             ),
//                           ),
//             ],
//           );
//         },
//         error: (error, stackTrace) {
//           return Center(
//             child: Text(error.toString()),
//           );
//         },
//         loading: () {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
