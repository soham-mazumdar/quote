import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quote/data/data.dart';
import 'package:quote/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit(this.quoteRepository) : super(QuoteState.initial());

  final QuoteRepository quoteRepository;

  getQuote({Function? onSuccess, Function(String)? onError}) async {
    // EMIT LOADING STATE
    emit(state.copyWith(apiStatus: ApiStatus.loading));

    // CALL REPO FUNCTION TO FETCH DATA
    final (e, data) = await quoteRepository.getQuote(null);
    if (data != null) {
      emit(
        state.copyWith(
          quote: data.first,
          apiStatus: ApiStatus.success,
        ),
      );
      onSuccess?.call();
    } else if (e != null) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
      onError?.call(e.message);
    }
  }

  cacheQuote({
    Function? onSuccess,
    Function(String)? onError,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedQuotes = prefs.getString('cachedQuotes');
    if (cachedQuotes != null) {
      final quotes = (jsonDecode(cachedQuotes) as List<dynamic>?)!
          .map((e) => Quote.fromJson(e))
          .toList();
      quotes.add(state.quote!);
      prefs.setString('cachedQuotes', jsonEncode(quotes));
    } else {
      final List<Quote> quotes = [];
      quotes.add(state.quote!);
      prefs.setString('cachedQuotes', jsonEncode(quotes));
    }
  }

  getCachedQuote({Function? onSuccess, Function(String)? onError}) async {
    // EMIT LOADING STATE
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final cachedQuotes = prefs.getString('cachedQuotes');

    if (cachedQuotes != null) {
      final quote = (jsonDecode(cachedQuotes) as List<dynamic>?)!
          .map((e) => Quote.fromJson(e))
          .toList();

      if (quote.isNotEmpty) {
        emit(
          state.copyWith(
            quote: quote.first,
            cachedQuotes: quote,
            apiStatus: ApiStatus.success,
          ),
        );
      }
    } else {
      onError?.call('No Cached Quotes');
    }
  }

  saveQuote({Function? onSuccess, Function? onError}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedQuotes = prefs.getString('savedQuotes');
    if (cachedQuotes != null) {
      // final List<Quote> quotes = jsonDecode(cachedQuotes);
      final quotes = (jsonDecode(cachedQuotes) as List<dynamic>?)!
          .map((e) => Quote.fromJson(e))
          .toList();

      quotes.add(state.quote!);
      prefs.setString('savedQuotes', jsonEncode(quotes));
    } else {
      final List<Quote> quotes = [];
      quotes.add(state.quote!);
      prefs.setString('savedQuotes', jsonEncode(quotes));
    }
  }

  getSavedQuote({Function? onSuccess, Function(String)? onError}) async {
    // EMIT LOADING STATE
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final savedQuotes = prefs.getString('savedQuotes');

    if (savedQuotes != null) {
      final quotes = (jsonDecode(savedQuotes) as List<dynamic>?)!
          .map((e) => Quote.fromJson(e))
          .toList();

      if (quotes.isNotEmpty) {
        emit(state.copyWith(savedQuotes: quotes));
        onSuccess?.call();
      }
    } else {
      onError?.call('No Saved Quotes');
    }
  }

  unsaveQuote({
    required Quote unsaveQuote,
    Function? onSuccess,
    Function? onError,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedQuotes = prefs.getString('savedQuotes');
    if (savedQuotes != null) {
      // REMOVE THE SAVED QUOTE
      final quotes = (jsonDecode(savedQuotes) as List<dynamic>?)!
          .map((e) => Quote.fromJson(e))
          .toList();

      quotes.removeWhere((element) => element.id == unsaveQuote.id);
      prefs.setString('savedQuotes', jsonEncode(quotes));
      emit(state.copyWith(savedQuotes: quotes));
    }
  }

  rateQuote({
    required double rate,
    Function? onSuccess,
    Function? onError,
  }) async {
    emit(state.copyWith(quote: state.quote!.copyWith(rate: rate)));
  }
}
