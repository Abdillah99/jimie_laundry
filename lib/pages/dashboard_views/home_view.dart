import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimie_laundry/widgets/categories_card.dart';
import 'package:jimie_laundry/widgets/promo_list.dart';
import 'package:jimie_laundry/config/failure.dart';
import 'package:jimie_laundry/config/nav.dart';
import 'package:jimie_laundry/datasources/promo_datasource.dart';
import 'package:jimie_laundry/datasources/shop_datasource.dart';
import 'package:jimie_laundry/models/promo_model.dart';
import 'package:jimie_laundry/models/shop_model.dart';
import 'package:jimie_laundry/pages/search_by_city_page.dart';
import 'package:jimie_laundry/providers/home_provider.dart';
import 'package:jimie_laundry/widgets/recomendation_list.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  static final edtSearch = TextEditingController();

  gotoSearchCity() {
    Nav.push(context, SearchByCityPage(query: edtSearch.text));
  }

  getPromo() {
    PromoDatasource.readLimit().then(
      (value) {
        value.fold(
          (failure) {
            switch (failure.runtimeType) {
              case ServerFailure:
                setHomePromoStatus(ref, 'server error');
                break;
              case NotFoundFailure:
                setHomePromoStatus(ref, 'Error Not Found');
                break;
              case ForbiddenFailure:
                setHomePromoStatus(ref, 'You don\'t have access');
                break;
              case BadRequestFailure:
                setHomePromoStatus(ref, 'Bad request');
                break;
              case UnauthorisedFailure:
                setHomePromoStatus(ref, 'Unauthorised');
                break;
              default:
                setHomePromoStatus(ref, 'Request error unknown');
                break;
            }
          },
          (result) {
            setHomePromoStatus(ref, 'Success');
            List data = result['data'];
            List<PromoModel> promos =
                data.map((e) => PromoModel.fromJson(e)).toList();
            ref.read(homePromoListProvider.notifier).setData(promos);
          },
        );
      },
    );
  }

  getRecomendation() {
    ShopDatasource.readRecomendationLimit().then(
      (value) {
        value.fold(
          (failure) {
            switch (failure.runtimeType) {
              case ServerFailure:
                setHomeRecomendationStatus(ref, 'server error');
                break;
              case NotFoundFailure:
                setHomeRecomendationStatus(ref, 'Error Not Found');
                break;
              case ForbiddenFailure:
                setHomeRecomendationStatus(ref, 'You don\'t have access');
                break;
              case BadRequestFailure:
                setHomeRecomendationStatus(ref, 'Bad request');
                break;
              case UnauthorisedFailure:
                setHomeRecomendationStatus(ref, 'Unauthorised');
                break;
              default:
                setHomeRecomendationStatus(ref, 'Request error unknown');
                break;
            }
          },
          (result) {
            setHomeRecomendationStatus(ref, 'Success');
            List data = result['data'];
            List<ShopModel> shops =
                data.map((e) => ShopModel.fromJson(e)).toList();
            ref.read(homeRecomendationListProvider.notifier).setData(shops);
          },
        );
      },
    );
  }

  refresh() {
    getPromo();
    getRecomendation();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => refresh(),
      child: ListView(
        children: [
          header(),
          categories(),
          DView.spaceHeight(20),
          promo(),
          DView.spaceHeight(20),
          recomendation(),
          DView.spaceHeight()
        ],
      ),
    );
  }

  Padding header() {
    Widget title() {
      return Text(
        'We\'re ready',
        style: GoogleFonts.ptSans(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget subtitle() {
      return Text(
        'to cleans your clothes',
        style: GoogleFonts.ptSans(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(),
          DView.spaceHeight(4),
          subtitle(),
          DView.spaceHeight(20),
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: Colors.green,
                    size: 20,
                  ),
                  DView.spaceWidth(4),
                  Text(
                    'Find by city',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[600],
                    ),
                  )
                ],
              ),
              DView.spaceHeight(8),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => gotoSearchCity(),
                                icon: const Icon(Icons.search)),
                            Expanded(
                              child: TextField(
                                controller: edtSearch,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search...',
                                ),
                                onSubmitted: (value) => gotoSearchCity(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    DView.spaceWidth(),
                    DButtonElevation(
                      onClick: () {},
                      mainColor: Colors.green,
                      splashColor: Colors.greenAccent,
                      width: 50,
                      radius: 10,
                      child: Icon(
                        Icons.tune,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Consumer categories() {
    return Consumer(
      builder: (_, wiRef, __) {
        String categorySelected = wiRef.watch(homeCategoryProvider);
        return CategoriesCard(ref: ref, categorySelected: categorySelected);
      },
    );
  }

  Consumer promo() {
    final pageController = PageController();

    return Consumer(
      builder: (_, wiRef, __) {
        List<PromoModel> list = wiRef.watch(homePromoListProvider);
        return PromoCard(
          pageController: pageController,
          list: list,
        );
      },
    );
  }

  Consumer recomendation() {
    return Consumer(
      builder: (_, wiRef, __) {
        List<ShopModel> list = wiRef.watch(homeRecomendationListProvider);
        return RecomendationCard(list: list);
      },
    );
  }
}
