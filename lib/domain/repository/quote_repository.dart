import 'package:quote/core/core.dart';
import 'package:quote/data/data.dart';

/// {@template quote_repository}
/// Repository which manages the quote domain.
/// {@endtemplate}
abstract class QuoteRepository {
  /// Returns a random Quote
  Future<(AppException?, List<Quote>?)> getQuote(String? count);
}
