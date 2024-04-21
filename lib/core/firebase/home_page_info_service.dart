import 'package:cloud_functions/cloud_functions.dart';

Future<HttpsCallableResult> requestWeatherUpdate() async {
  final functions = FirebaseFunctions.instance;
  return functions.httpsCallable('homePageInfo-updateWeather').call();
}
