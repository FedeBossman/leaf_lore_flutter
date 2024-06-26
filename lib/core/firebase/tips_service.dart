import 'package:cloud_functions/cloud_functions.dart';

Future<HttpsCallableResult> getDailyTip() async {
  final functions = FirebaseFunctions.instance;
  return functions.httpsCallable('tip-getDailyTip').call();
}

Future<HttpsCallableResult> getSeasonalTip() async {
  final functions = FirebaseFunctions.instance;
  return functions.httpsCallable('tip-getSeasonalTip').call();
}
