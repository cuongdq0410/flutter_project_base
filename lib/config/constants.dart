import 'package:enum_to_string/enum_to_string.dart';

enum Flavor { dev, stag, prod }

class Constants {
  const Constants({
    required this.endpoint,
    required this.socket,
    required this.packageName,
    required this.bundleId,
  });

  factory Constants.shared() {
    if (_instance != null) {
      return _instance!;
    }

    final flavor = EnumToString.fromString(
        Flavor.values, const String.fromEnvironment('FLAVOR'));
    switch (flavor) {
      case Flavor.prod:
        return Constants._prod();

      case Flavor.stag:
        return Constants._stag();

      case Flavor.dev:
      default:
        return Constants._dev();
    }
  }

  factory Constants._dev() {
    return const Constants(
      endpoint: 'https://api.pexels.com/v1',
      socket: '',
      packageName: '',
      bundleId: '',
    );
  }

  factory Constants._stag() {
    return const Constants(
      endpoint: 'https://api.pexels.com/v1',
      socket: '',
      packageName: '',
      bundleId: '',
    );
  }

  factory Constants._prod() {
    return const Constants(
      endpoint: 'https://api.pexels.com/v1',
      socket: '',
      packageName: '',
      bundleId: '',
    );
  }

  final String endpoint;
  final String socket;
  final String packageName;
  final String bundleId;

  static Constants? _instance;
}

enum AuthenticateStatus { authenticated, unAuthenticate }
