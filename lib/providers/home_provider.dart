import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimie_laundry/models/promo_model.dart';
import 'package:jimie_laundry/models/shop_model.dart';

final homeCategoryProvider = StateProvider.autoDispose((ref) => 'All');
final homePromoStatusProvider = StateProvider.autoDispose((ref) => '');
final homeRecomendationStatusProvider = StateProvider.autoDispose((ref) => '');

setHomeCategory(WidgetRef ref, String newCategory) {
  ref.read(homeCategoryProvider.notifier).state = newCategory;
}

setHomePromoStatus(WidgetRef ref, String newStatus) {
  ref.read(homePromoStatusProvider.notifier).state = newStatus;
}

setHomeRecomendationStatus(WidgetRef ref, String newStatus) {
  ref.read(homeRecomendationStatusProvider.notifier).state = newStatus;
}

final homePromoListProvider =
    StateNotifierProvider.autoDispose<HomePromoList, List<PromoModel>>(
        (ref) => HomePromoList([]));

class HomePromoList extends StateNotifier<List<PromoModel>> {
  HomePromoList(super.state);

  setData(List<PromoModel> newData) {
    state = newData;
  }
}

final homeRecomendationListProvider =
    StateNotifierProvider.autoDispose<HomeRecomendationList, List<ShopModel>>(
        (ref) => HomeRecomendationList([]));

class HomeRecomendationList extends StateNotifier<List<ShopModel>> {
  HomeRecomendationList(super.state);

  setData(List<ShopModel> newData) {
    state = newData;
  }
}
