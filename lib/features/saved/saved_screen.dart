import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/di/di.dart';
import 'package:quote/features/blocs/quote/quote_cubit.dart';
import 'package:quote/ui/components/column_builder.dart';
import 'package:quote/ui/components/saved_quote_card.dart';
import 'package:quote/ui/theme/theme.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteCubit, QuoteState>(
      bloc: getItInstance<QuoteCubit>(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: AppColors.primary,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text(
              'My Quotes',
              style: AppTextStyle.lgSB.copyWith(color: AppColors.white),
            ),
          ),
          body: state.savedQuotes != null && state.savedQuotes!.isNotEmpty
              ? ColumnBuilder(
                  itemBuilder: (context, index) {
                    final q = state.savedQuotes![index];
                    return SavedQuoteCard(
                      quote: q,
                      inSlide: false,
                    );
                  },
                  itemCount: state.savedQuotes!.length,
                )
              : const Center(child: LinearProgressIndicator()),
        );
      },
    );
  }
}
