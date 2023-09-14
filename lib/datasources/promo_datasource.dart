import 'package:dartz/dartz.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/config/app_request.dart';
import 'package:jimie_laundry/config/app_response.dart';
import 'package:jimie_laundry/config/app_session.dart';
import 'package:jimie_laundry/config/failure.dart';
import 'package:http/http.dart' as http;

class PromoDatasource {
  static Future<Either<Failure, Map>> readLimit() async {
    Uri url = Uri.parse('${AppConstants.baseURL}/promo/limit');
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
