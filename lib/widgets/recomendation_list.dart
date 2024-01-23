import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimie_laundry/config/app_assets.dart';
import 'package:jimie_laundry/config/app_colors.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/config/nav.dart';
import 'package:jimie_laundry/models/shop_model.dart';
import 'package:jimie_laundry/pages/detail_shop_page.dart';
import 'package:jimie_laundry/widgets/error_background.dart';

class RecomendationCard extends StatelessWidget {
  const RecomendationCard({
    super.key,
    required this.list,
  });

  final List<ShopModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DView.textTitle('Recomendation', color: Colors.black),
              DView.textAction(
                () {},
                text: 'See All',
                color: AppColors.primary,
              )
            ],
          ),
        ),
        if (list.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ErrorBackground(
              ratio: 1.2,
              message: 'No Recomendation Yet',
            ),
          ),
        if (list.isNotEmpty)
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                ShopModel item = list[index];

                return GestureDetector(
                  onTap: () {
                    Nav.push(context, DetailShopPage(shop: item));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      index == 0 ? 30 : 10,
                      0,
                      index == list.length - 1 ? 30 : 10,
                      0,
                    ),
                    width: 200,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            placeholder:
                                AssetImage(AppAssets.placeholderLaundry),
                            image: NetworkImage(
                              '${AppConstants.baseImageURL}/shop/${item.image}',
                            ),
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 150,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(11),
                              ),
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          bottom: 8,
                          right: 8,
                          child: Column(
                            children: [
                              Row(
                                children: ['Regular', 'Express'].map(
                                  (e) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          height: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              DView.spaceHeight(8),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: GoogleFonts.ptSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    DView.spaceHeight(4),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: item.rate,
                                          itemCount: 5,
                                          allowHalfRating: true,
                                          itemPadding: const EdgeInsets.all(0),
                                          unratedColor: Colors.grey[300],
                                          itemBuilder: (context, index) {
                                            return const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            );
                                          },
                                          itemSize: 12,
                                          onRatingUpdate: (value) {},
                                          ignoreGestures: true,
                                        ),
                                        DView.spaceWidth(4),
                                        Text(
                                          '(${item.rate})',
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 11,
                                          ),
                                        )
                                      ],
                                    ),
                                    DView.spaceHeight(4),
                                    Text(
                                      item.location,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
