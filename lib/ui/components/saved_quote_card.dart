import 'package:flutter/material.dart';
import 'package:quote/data/model/quote.dart';
import 'package:quote/di/di.dart';
import 'package:quote/features/blocs/quote/quote_cubit.dart';
import 'package:quote/ui/components/custom_icon_button.dart';
import 'package:quote/ui/theme/theme.dart';
import 'package:share_plus/share_plus.dart';

class SavedQuoteCard extends StatelessWidget {
  const SavedQuoteCard({
    super.key,
    required this.quote,
    required this.inSlide,
  });

  final Quote quote;
  final bool inSlide;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          boxShadow: boxShadow1,
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            quote.quote,
            textAlign: TextAlign.center,
            style: inSlide
                ? AppTextStyle.xsSB
                : AppTextStyle.smSB.copyWith(color: AppColors.text),
          ),
          const SizedBox(height: 20),
          if (!inSlide)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    CustomIconButton(
                      icon: Icons.delete,
                      iconColor: AppColors.error,
                      onTap: () {
                        getItInstance<QuoteCubit>()
                            .unsaveQuote(unsaveQuote: quote);
                      },
                      transparent: true,
                    ),
                    const SizedBox(width: 5),
                    CustomIconButton(
                      icon: Icons.share,
                      iconColor: AppColors.primary,
                      onTap: () {
                        Share.share(
                            '${quote.quote} ~ ${quote.author} | sent from soham\'s quote app');
                      },
                      transparent: true,
                    ),
                  ],
                ),
                Text(
                  quote.author,
                  style: AppTextStyle.xsSB,
                  textAlign: TextAlign.right,
                )
              ],
            )
        ],
      ),
    );
  }
}
