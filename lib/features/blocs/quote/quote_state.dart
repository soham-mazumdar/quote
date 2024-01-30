part of 'quote_cubit.dart';

enum ApiStatus { notInitiated, loading, success, error }

class QuoteState extends Equatable {
  const QuoteState({
    this.quote,
    this.savedQuotes,
    this.cachedQuotes,
    required this.apiStatus,
  });

  final Quote? quote;
  final List<Quote>? savedQuotes;
  final List<Quote>? cachedQuotes;
  final ApiStatus apiStatus;

  @override
  List<Object?> get props => [
        quote,
        apiStatus,
        savedQuotes,
        cachedQuotes,
      ];

  factory QuoteState.initial() {
    return const QuoteState(apiStatus: ApiStatus.notInitiated);
  }

  QuoteState copyWith({
    ApiStatus? apiStatus,
    Quote? quote,
    List<Quote>? savedQuotes,
    List<Quote>? cachedQuotes,
  }) {
    return QuoteState(
      apiStatus: apiStatus ?? this.apiStatus,
      quote: quote ?? this.quote,
      savedQuotes: savedQuotes ?? this.savedQuotes,
      cachedQuotes: cachedQuotes ?? this.cachedQuotes,
    );
  }
}
