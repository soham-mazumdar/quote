import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quote/data/data.dart';
import 'package:quote/di/di.dart';
import 'package:quote/features/blocs/quote/quote_cubit.dart';
import 'package:quote/ui/components/custom_icon_button.dart';
import 'package:quote/ui/theme/theme.dart';
import 'package:share_plus/share_plus.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
    required this.quote,
  });
  final Quote quote;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Center(),
          Text(
            quote.quote,
            textAlign: TextAlign.center,
            style: AppTextStyle.lgSB,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Text(
              quote.author,
              style: AppTextStyle.xsSB,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  getItInstance<QuoteCubit>().rateQuote(rate: rating);
                },
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              CustomIconButton(
                icon: Icons.share,
                onTap: () {
                  Share.share(
                      '${quote.quote} ~ ${quote.author} : sent from soham\'s quote app');
                },
              ),
              const SizedBox(width: 10),
              CustomIconButton(
                icon: Icons.save,
                onTap: () {
                  getItInstance<QuoteCubit>().saveQuote();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
