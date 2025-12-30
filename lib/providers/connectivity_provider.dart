import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Add this to your enum
enum ConnectionStatus { online, lowSense, offline, initial }

final connectionProvider = StreamProvider<ConnectionStatus>((ref) async* {
  final connectivity = Connectivity();
  
  // Start with 'initial' so we know the app just launched
  yield ConnectionStatus.initial;

  final initialResult = await connectivity.checkConnectivity();
  yield _mapResultToStatus(initialResult);

  yield* connectivity.onConnectivityChanged.map((results) {
    return _mapResultToStatus(results);
  });
});

// Helper to handle the new List<ConnectivityResult> in newer versions of the package
ConnectionStatus _mapResultToStatus(List<ConnectivityResult> results) {
  if (results.isEmpty || results.contains(ConnectivityResult.none)) {
    return ConnectionStatus.offline;
  }
  // Optional: logic for lowSense if results.contains(ConnectivityResult.mobile)
  return ConnectionStatus.online;
}