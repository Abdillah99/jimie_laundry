import 'package:dartz/dartz.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/config/app_request.dart';
import 'package:jimie_laundry/config/app_response.dart';
import 'package:jimie_laundry/config/app_session.dart';
import 'package:jimie_laundry/config/failure.dart';
import 'package:http/http.dart' as http;

class ShopDatasource {
  static Future<Either<Failure, Map>> readRecomendationLimit() async {
    Uri url = Uri.parse('${AppConstants.baseURL}/shop/recomendation/limit');
    final token = await AppSession.getBearerToken();

    try {
      final response = await http.get(
        url,
        headers: AppRequest.header(token),
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(FetchFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map>> searchByCity(String name) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/shop/search/city/$name');
    final token = await AppSession.getBearerToken();

    try {
      final response = await http.get(
        url,
        headers: AppRequest.header(token),
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(FetchFailure(e.toString()));
    }
  }
}
