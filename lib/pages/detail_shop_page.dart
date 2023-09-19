import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/models/shop_model.dart';

class DetailShopPage extends StatelessWidget {
  const DetailShopPage({
    super.key,
    required this.shop,
  });

  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          headerImage(context),
        ],
      ),
    );
  }

  Widget headerImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                '${AppConstants.baseImageURL}/shop/${shop.image}',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DView.spaceHeight(8),
                    RatingBar.builder(
                      initialRating: shop.rate,
                      itemCount: 5,
                      allowHalfRating: true,
                      itemPadding: EdgeInsets.all(0),
                      unratedColor: Colors.grey[300],
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemSize: 12,
                      onRatingUpdate: (value) {},
                      ignoreGestures: true,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 36,
              left: 16,
              child: SizedBox(
                height: 36,
                child: FloatingActionButton.extended(
                  heroTag: 'fab-back-button',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.white,
                  icon: const Icon(
                    Icons.navigate_before,
                    color: Colors.black,
                  ),
                  extendedIconLabelSpacing: 0,
                  extendedPadding: EdgeInsets.only(left: 10, right: 16),
                  label: Text(
                    'Back',
                    style: TextStyle(
                      height: 1,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
