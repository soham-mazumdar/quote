import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:quote/features/blocs/quote/quote_cubit.dart';
import 'package:quote/core/core.dart';
import 'package:quote/data/data.dart';
import 'package:quote/domain/domain.dart';

final getItInstance = GetIt.I;

init() async {
  // SERVICES
  getItInstance.registerLazySingleton<Client>(Client.new);
  getItInstance.registerLazySingleton<HttpClient>(
    () => HttpClient(client: getItInstance()),
  );

  getItInstance.registerLazySingleton<QuoteRepository>(
      () => QuoteRepositoryImpl(getItInstance()));

  // GLOBAL BLOCS
  getItInstance
      .registerLazySingleton<QuoteCubit>(() => QuoteCubit(getItInstance()));
}
