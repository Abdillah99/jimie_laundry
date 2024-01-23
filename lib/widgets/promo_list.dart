import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimie_laundry/config/app_assets.dart';
import 'package:jimie_laundry/config/app_colors.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/config/app_format.dart';
import 'package:jimie_laundry/models/promo_model.dart';
import 'package:jimie_laundry/widgets/error_background.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromoCard extends ConsumerWidget {
  final PageController pageController;
  final List<PromoModel> list;

  const PromoCard({
    super.key,
    required this.pageController,
    required this.list,
  });

  Padding renderEmpty() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: ErrorBackground(
        ratio: 16 / 9,
        message: 'No Promo',
      ),
    );
  }

  AspectRatio renderItem() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PageView.builder(
        controller: pageController,
        itemCount: list.length,
        itemBuilder: (context, index) {
          PromoModel item = list[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      placeholder: AssetImage(AppAssets.placeholderLaundry),
                      image: NetworkImage(
                        '${AppConstants.baseImageURL}/promo/${item.image}',
                      ),
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.shop.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        DView.spaceHeight(4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${AppFormat.shortPrice(item.newPrice)}/Kg',
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            DView.spaceWidth(),
                            Text(
                              '${AppFormat.shortPrice(item.oldPrice)}/Kg',
                              style: const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DView.textTitle(
                'Promo',
                color: Colors.black,
              ),
              DView.textAction(
                () {},
                color: AppColors.primary,
              )
            ],
          ),
        ),
        if (list.isEmpty) renderEmpty(),
        if (list.isNotEmpty) renderItem(),
        SmoothPageIndicator(
          controller: pageController,
          count: list.length,
          effect: WormEffect(
            dotWidth: 12,
            dotHeight: 4,
            dotColor: Colors.grey[300]!,
            activeDotColor: AppColors.primary,
          ),
        )
      ],
    );
  }
}
