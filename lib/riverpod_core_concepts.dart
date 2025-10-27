// Core Riverpod Concepts Explained
// This file demonstrates the fundamental concepts of how Riverpod works

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. BASIC PROVIDER - For simple values
// This provider will always return the same value
final simpleProvider = Provider<String>((ref) {
  return 'Hello from Riverpod!';
});

final simpleProviderInt = Provider<int>((ref) {
  return 10;
});
//final mySimpleProvide
// 2. FUTURE PROVIDER - For async operations (like your joke provider)
// This mimics your randomJokeProvider
final futureProvider = FutureProvider<String>((ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 2));
  return 'Data loaded from future!';
});

// 3. AUTO DISPOSE PROVIDER - Automatically disposed when no longer watched
final autoDisposeProvider = Provider.autoDispose<int>((ref) {
  print('AutoDispose provider created');
  return 42;
});

// Widget that demonstrates these concepts
class RiverpodConceptsDemo extends ConsumerWidget {
  const RiverpodConceptsDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // CONCEPT 1: Reading a simple provider
    final simpleValue = ref.watch(simpleProvider);

    // CONCEPT 2: Watching a future provider
    final futureValue = ref.watch(futureProvider);

    // CONCEPT 3: Reading without watching (won't rebuild when changes)
    final readOnlyValue = ref.read(simpleProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Core Concepts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple Provider Example
            Text(
              'Simple Provider: $simpleValue',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Future Provider Example
            const Text(
              'Future Provider:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            futureValue.when(
              data: (data) => Text('Data: $data'),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            const SizedBox(height: 20),

            // Auto Dispose Example
            Text(
              'Auto Dispose Provider: $readOnlyValue',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Invalidate Example
            ElevatedButton(
              onPressed: () {
                // This forces the future provider to refresh
                ref.invalidate(futureProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Future provider invalidated!')),
                );
              },
              child: const Text('Invalidate Future Provider'),
            ),
          ],
        ),
      ),
    );
  }
}

// KEY CONCEPTS SUMMARY:

/*
1. PROVIDER TYPES:
   - Provider: For immutable values
   - FutureProvider: For async operations that complete once
   - StreamProvider: For streams of data
   - AsyncNotifierProvider: For complex async state management (Riverpod 3.x)

2. WATCHING PROVIDERS:
   - ref.watch(): Rebuilds widget when provider changes
   - ref.read(): Reads value once, no rebuilds
   - ref.listen(): Adds callback for state changes

3. PROVIDER LIFECYCLE:
   - Providers are created when first watched
   - They persist until app ends (unless autoDispose)
   - ref.invalidate() forces provider to refresh

4. AUTO DISPOSE:
   - Provider.autoDispose automatically cleans up
   - Useful for memory management
   - Provider recreates when watched again

5. HOW IT WORKS UNDER THE HOOD:
   - ProviderScope creates a container
   - Providers register with this container
   - ref.watch() creates a dependency
   - When provider state changes, dependent widgets rebuild
   - No manual state management needed!

6. IN YOUR JOKE APP:
   - randomJokeProvider is a FutureProvider<Joke>
   - ref.watch(randomJokeProvider) automatically triggers the fetch
   - The provider handles loading, error, and data states
   - ref.invalidate(randomJokeProvider) refreshes the joke
*/
