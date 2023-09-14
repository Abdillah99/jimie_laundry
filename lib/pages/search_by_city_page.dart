import 'package:flutter/material.dart';
import 'package:jimie_laundry/config/failure.dart';
import 'package:jimie_laundry/datasources/shop_datasource.dart';
import 'package:jimie_laundry/models/shop_model.dart';

class SearchByCityPage extends StatefulWidget {
  const SearchByCityPage({
    super.key,
    required this.query,
  });
  final String query;

  @override
  State<SearchByCityPage> createState() => _SearchByCityPageState();
}

class _SearchByCityPageState extends State<SearchByCityPage> {
  final edtSearch = TextEditingController();

  execute() {
    ShopDatasource.searchByCity(edtSearch.text).then((value) {
      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              break;

            case NotFoundFailure:
              break;

            case ForbiddenFailure:
              break;

            case BadRequestFailure:
              break;

            case UnauthorisedFailure:
              break;
            default:
          }
        },
        (result) {
          List data = result['data'];
          List<ShopModel> list =
              data.map((e) => ShopModel.fromJson(e)).toList();
        },
      );
    });
  }

  @override
  void initState() {
    if (widget.query != '') {
      edtSearch.text = widget.query;
      execute();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Row(
            children: [
              const Text(
                'City',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  height: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
