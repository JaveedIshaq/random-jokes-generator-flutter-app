// Riverpod Flow Diagram for Your Joke App
// This file contains a visual representation of how Riverpod works in your app

import 'package:flutter/material.dart';

class RiverpodFlowDiagram extends StatelessWidget {
  const RiverpodFlowDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Flow Diagram')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How Riverpod Works in Your Joke App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            _buildStep(
              '1. App Initialization',
              'ProviderScope wraps the app in main.dart',
              'Creates a container for all providers',
            ),
            
            _buildArrow(),
            
            _buildStep(
              '2. Widget Build',
              'HomeView builds with Consumer widget',
              'Consumer accesses the ref object',
            ),
            
            _buildArrow(),
            
            _buildStep(
              '3. First Watch',
              'ref.watch(randomJokeProvider) is called',
              'Riverpod checks if provider has been executed',
            ),
            
            _buildArrow(),
            
            _buildStep(
              '4. Provider Execution',
              'FutureProvider function runs automatically',
              'fetchJoke() makes HTTP request',
            ),
            
            _buildArrow(),
            
            _buildStep(
              '5. State Management',
              'Riverpod tracks the Future<Joke> state',
              'Loading → Data/Error states',
            ),
            
            _buildArrow(),
            
            _buildStep(
              '6. UI Update',
              'Consumer rebuilds when state changes',
              'Switch statement handles all states',
            ),
            
            _buildArrow(),
            
            _buildStep(
              '7. User Interaction',
              'Button press calls ref.invalidate()',
              'Provider refreshes and cycle repeats',
            ),
            
            const SizedBox(height: 30),
            
            const Text(
              'Key Points:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            _buildPoint(
              'No explicit fetchJoke() call needed in UI',
            ),
            _buildPoint(
              'ref.watch() automatically triggers provider execution',
            ),
            _buildPoint(
              'Riverpod handles loading, error, and data states',
            ),
            _buildPoint(
              'State is cached until invalidated',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String title, String description, String detail) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(description),
          const SizedBox(height: 4),
          Text(
            detail,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Icon(
          Icons.arrow_downward,
          size: 30,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}