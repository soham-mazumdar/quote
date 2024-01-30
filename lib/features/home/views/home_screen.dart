import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:quote/app/router/app_routes.dart';
import 'package:quote/di/di.dart';
import 'package:quote/features/blocs/quote/quote_cubit.dart';
import 'package:quote/ui/components/custom_icon_button.dart';
import 'package:quote/ui/components/quote_card.dart';
import 'package:quote/ui/components/saved_quote_card.dart';
import 'package:quote/ui/theme/theme.dart';
import 'package:quote/ui/components/app_snackbar.dart';
import 'package:shake/shake.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        getItInstance<QuoteCubit>().getQuote();
      },
      shakeCountResetTime: 500,
    );
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteCubit, QuoteState>(
      bloc: getItInstance<QuoteCubit>()
        ..getQuote(
          onSuccess: () {
            getItInstance<QuoteCubit>().cacheQuote();
          },
          onError: (msg) async {
            AppSnackbar(context).show(
              msg,
              context,
            );
            await Future.delayed(const Duration(seconds: 2));
            getItInstance<QuoteCubit>().getCachedQuote(
              onError: (msg) {
                AppSnackbar(context).show(
                  msg,
                  context,
                );
              },
            );
          },
        )
        ..getSavedQuote()
        ..getCachedQuote(),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            centerTitle: true,
            title: Text(
              'Random Quotes',
              style: AppTextStyle.lgSB.copyWith(color: AppColors.white),
            ),
            actions: [
              CustomIconButton(
                icon: Icons.save_alt,
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.saved);
                },
                iconColor: AppColors.white,
                transparent: true,
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Center(),
                if (state.apiStatus == ApiStatus.loading ||
                    state.apiStatus == ApiStatus.notInitiated)
                  const SizedBox(
                    width: 140,
                    height: 10,
                    child: LinearProgressIndicator(color: AppColors.primary),
                  )
                else if (state.apiStatus == ApiStatus.error)
                  const Text('No User Found!')
                else
                  Column(
                    children: [
                      QuoteCard(quote: state.quote!),
                      GestureDetector(
                        onTap: () {
                          getItInstance<QuoteCubit>().getQuote();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Next',
                            style: AppTextStyle.xsSB
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                if (!kIsWeb)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    color: AppColors.bg,
                    child: const Text('Shake the phone to get a new quote'),
                  ),
                if (state.cachedQuotes != null)
                  CarouselSlider(
                    options: CarouselOptions(height: 150.0),
                    items: state.cachedQuotes?.map((quote) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ListView(
                            children: [
                              SavedQuoteCard(quote: quote, inSlide: true),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
