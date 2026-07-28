import 'package:jaspr/jaspr.dart';

String assetUrl(String path) {
  final cleanPath = path.startsWith('/') ? path.substring(1) : path;
  return kDebugMode ? '/$cleanPath' : '/my_portfolio/$cleanPath';
}
