import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quote/core/core.dart';
import 'package:quote/data/data.dart';
import 'package:quote/domain/repository/quote_repository.dart';
import 'package:quote/features/blocs/quote/quote_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late QuoteCubit quoteCubit;
  late MockQuoteRepository mockQuoteRepository;

  group('Quote Cubit', () {
    group('getQuotes', () {
      final testQuote = Quote(
        id: '1',
        quote: 'Test quote',
        author: 'Test author',
      );

      setUpAll(() {
        mockQuoteRepository = MockQuoteRepository();
        quoteCubit = QuoteCubit(mockQuoteRepository);
      });
      test('emits initial state with loading status', () async {
        when(() => mockQuoteRepository.getQuote(null))
            .thenAnswer((_) async => (null, null)); // Simulate error

        expect(quoteCubit.state,
            QuoteState.initial().copyWith(apiStatus: ApiStatus.notInitiated));

        await quoteCubit.getQuote();
        expect(
            quoteCubit.state, const QuoteState(apiStatus: ApiStatus.loading));
      });

      test(
        'emits state with quote and success status on successful fetch',
        () async {
          when(() => mockQuoteRepository.getQuote(null))
              .thenAnswer((_) async => (null, [testQuote]));

          await quoteCubit.getQuote();
          expect(
            quoteCubit.state,
            QuoteState(
              quote: testQuote,
              apiStatus: ApiStatus.success,
            ),
          );
        },
      );

      test('emits state with error status on fetch failure', () async {
        final testError =
            ServerException(message: 'server exception', code: '');
        when(() => mockQuoteRepository.getQuote(null))
            .thenAnswer((_) async => (testError, null));

        await quoteCubit.getQuote();
        expect(quoteCubit.state,
            QuoteState(quote: testQuote, apiStatus: ApiStatus.error));
      });
    });
  });
}
