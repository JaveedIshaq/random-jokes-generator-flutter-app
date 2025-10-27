import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/joke.dart';
import 'package:mobile/riverpod_core_concepts.dart';
import 'package:mobile/riverpod_flow_diagram.dart';
import 'package:mobile/riverpod_interactive_demo.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Open dialog with showing Buttons to Navigate Riverpod related demos
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Riverpod Demos'),
                  content: const Text(
                    'Choose a demo to explore Riverpod concepts.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RiverpodFlowDiagram(),
                          ),
                        );
                      },
                      child: const Text('Flow Diagram'),
                    ),

                    //
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RiverpodConceptsDemo(),
                          ),
                        );
                      },
                      child: const Text('Riverpod Concepts'),
                    ),

                    //
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const RiverpodInteractiveDemo(),
                          ),
                        );
                      },
                      child: const Text('Riverpod Interactive Demo'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Consumer(
          builder: (context, ref, child) {
            final randomJoke = ref.watch(randomJokeProvider);
            return Stack(
              alignment: Alignment.center,
              children: [
                switch (randomJoke) {
                  // When the request completes successfully, we display the joke.
                  AsyncValue(:final value?) => SelectableText(
                    '${value.setup}\n\n${value.punchline}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                  AsyncValue(error: != null) => Text('Error Fetching Joke'),
                  AsyncValue() => const CircularProgressIndicator(),
                },

                Positioned(
                  bottom: 20,
                  child: ElevatedButton(
                    onPressed: () => ref.invalidate(randomJokeProvider),
                    child: const Text('Get another joke'),
                  ),
                ),

                if (randomJoke.isRefreshing)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
