import 'package:quote/core/core.dart';
import 'package:quote/data/data.dart';
import 'package:quote/data/model/quote.dart';
import 'package:quote/domain/domain.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  QuoteRepositoryImpl(HttpClient client) : _client = client;

  final HttpClient _client;

  @override
  Future<(AppException?, List<Quote>?)> getQuote(String? count) async {
    try {
      final futures = [
        _client.makeRequest(
          RequestMethod.get,
          delay: const Duration(seconds: 0),
          baseUrl: 'https://api.quotable.io/',
          path: 'quotes/random?limit=${count ?? 1}',
        ),
        _client.makeRequest(
          RequestMethod.get,
          delay: const Duration(seconds: 0),
          baseUrl: 'https://quote-garden.onrender.com/api/v3/',
          path: 'quotes/random?limit=${count ?? 1}',
        ),
      ];

      final res = (await Future.any(futures));

      List<Quote>? ret;
      if (res.length == 1) {
        ret = (res as List<dynamic>)
            .map((e) => Quote.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        ret = (res['data'] as List<dynamic>)
            .map((e) => Quote.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return (null, ret);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }
}
