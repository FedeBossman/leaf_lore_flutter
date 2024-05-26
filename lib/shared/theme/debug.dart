import 'package:flutter/foundation.dart';

const bool debugFirebase = false;
const bool debugElements = false;

// function that returns kDebugMode and debugElements
bool get debugMode => kDebugMode && debugFirebase;
bool get debugModeElements => kDebugMode && debugElements;