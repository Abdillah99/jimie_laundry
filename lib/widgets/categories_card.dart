import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/providers/home_provider.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    super.key,
    required this.ref,
    required this.categorySelected,
  });

  final WidgetRef ref;
  final String categorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.homeCategories.length,
        itemBuilder: (context, index) {
          String category = AppConstants.homeCategories[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? 30 : 8,
              0,
              index == AppConstants.homeCategories.length - 1 ? 30 : 8,
              0,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setHomeCategory(ref, category);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: categorySelected == category
                        ? Colors.green
                        : Colors.grey[400]!,
                  ),
                  color: categorySelected == category
                      ? Colors.green
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  category,
                  style: TextStyle(
                    height: 1,
                    color: categorySelected == category
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
