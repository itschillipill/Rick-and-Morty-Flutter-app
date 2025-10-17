import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dependencies.dart';
import 'dependencies_initialization.dart';

typedef InitializationProgressTuple = ({int progress, String message});

abstract interface class InitializationProgressListenable
    implements ValueListenable<InitializationProgressTuple> {}

class InitializationExecutor
    with ChangeNotifier
    implements InitializationProgressListenable {
  InitializationExecutor();

  Future<Dependencies>? _$currentInitialization;
  @override
  InitializationProgressTuple get value => _value;
  InitializationProgressTuple _value = (progress: 0, message: '');
  Future<Dependencies> call({
    bool deferFirstFrame = false,
    List<DeviceOrientation>? orientations,
    void Function(int progress, String message)? onProgress,
    void Function(Dependencies dependencies)? onSuccess,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) =>
      _$currentInitialization ??= Future<Dependencies>(() async {
        late final WidgetsBinding binding;
        final stopwatch = Stopwatch()..start();
        void notifyProgress(int progress, String message) {
          _value = (progress: progress.clamp(0, 100), message: message);
          onProgress?.call(_value.progress, _value.message);
          notifyListeners();
        }

        notifyProgress(0, 'Initializing');
        try {
          binding = WidgetsFlutterBinding.ensureInitialized();
          if (deferFirstFrame) binding.deferFirstFrame();
          await _catchExceptions();
          if (orientations != null)
            await SystemChrome.setPreferredOrientations(orientations);
          final dependencies = await $initializeDependencies(
          ).timeout(const Duration(minutes: 5));
          notifyProgress(100, 'Done');
          onSuccess?.call(dependencies);
          return dependencies;
        } on Object catch (error, stackTrace) {
          onError?.call(error, stackTrace);
          print(error);
          print(stackTrace);
          rethrow;
        } finally {
          stopwatch.stop();
          binding.addPostFrameCallback((_) {
            if (deferFirstFrame) binding.allowFirstFrame();
          });
          _$currentInitialization = null;
        }
      });

  Future<void> _catchExceptions() async {
    try {
      PlatformDispatcher.instance.onError = (error, stackTrace) {
        print(error);
        print(stackTrace);
        return true;
      };
    } on Object catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }
}
