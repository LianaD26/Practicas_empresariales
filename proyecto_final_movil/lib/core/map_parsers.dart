import 'package:cloud_firestore/cloud_firestore.dart';

/// Parsea fechas desde Firestore (Timestamp), JSON local (String ISO) o DateTime.
DateTime parseMapDateTime(dynamic value, {DateTime? defaultValue}) {
  final fallback = defaultValue ?? DateTime.now();
  if (value == null) return fallback;
  if (value is DateTime) return value;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.parse(value);
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  return fallback;
}

/// Igual que [parseMapDateTime] pero permite valores nulos.
DateTime? parseMapDateTimeNullable(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.parse(value);
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  return null;
}
