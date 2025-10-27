import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This provider mimics your joke provider but with a counter
// to help visualize when it's being called
final counterProvider = FutureProvider<int>((ref) async {
  print('Provider executing...'); // This will print when the provider runs
  await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
  return DateTime.now().millisecondsSinceEpoch % 100; // Random-ish number
});

class RiverpodInteractiveDemo extends ConsumerWidget {
  const RiverpodInteractiveDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is the key line - watching the provider triggers its execution
    final counterAsync = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Interactive Demo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Watch the console output when you press buttons!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // This shows the current state of the provider
              counterAsync.when(
                data: (value) => Column(
                  children: [
                    const Text(
                      'Provider returned:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$value',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '(This value is cached until invalidated)',
                      style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                loading: () => const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Provider is executing...'),
                  ],
                ),
                error: (error, stack) => Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Button to invalidate the provider
              ElevatedButton(
                onPressed: () {
                  print('Button pressed - invalidating provider...');
                  ref.invalidate(counterProvider);
                },
                child: const Text('Invalidate Provider'),
              ),
              
              const SizedBox(height: 16),
              
              // Button to read without watching (no rebuild)
              ElevatedButton(
                onPressed: () async {
                  print('Reading provider without watching...');
                  final value = await ref.read(counterProvider.future);
                  print('Read value: $value');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Read value: $value')),
                    );
                  }
                },
                child: const Text('Read Provider (No Watch)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
KEY TAKEAWAYS:

1. AUTOMATIC EXECUTION:
   - The provider function runs automatically when first watched
   - No explicit call needed - ref.watch() triggers it

2. CACHING:
   - After first execution, the value is cached
   - Subsequent watches return the cached value immediately
   - Provider only re-executes when invalidated

3. STATE MANAGEMENT:
   - Riverpod handles loading, data, and error states
   - The when() method provides a clean way to handle all states
   - UI automatically rebuilds when state changes

4. WATCH vs READ:
   - ref.watch(): Creates dependency, rebuilds widget on changes
   - ref.read(): One-time read, no rebuilds, no dependency

5. INVALIDATE:
   - ref.invalidate() forces provider to re-execute
   - Clears the cache and triggers a new execution
   - Useful for refresh functionality

This is exactly how your joke provider works:
- ref.watch(randomJokeProvider) triggers the fetch
- The joke is cached until you press "Get another joke"
- That button calls ref.invalidate(randomJokeProvider)
- This forces a new fetch with a new joke
*/