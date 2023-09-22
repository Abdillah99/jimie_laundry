import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/config/app_session.dart';
import 'package:jimie_laundry/config/failure.dart';
import 'package:jimie_laundry/datasources/laundry_datasource.dart';
import 'package:jimie_laundry/models/laundry_model.dart';
import 'package:jimie_laundry/models/user_model.dart';
import 'package:jimie_laundry/providers/my_laundry_provider.dart';

class MyLaundryView extends ConsumerStatefulWidget {
  const MyLaundryView({super.key});

  @override
  ConsumerState<MyLaundryView> createState() => _MyLaundryViewState();
}

class _MyLaundryViewState extends ConsumerState<MyLaundryView> {
  late UserModel user;

  getMyLaundry() {
    LaundryDataSource.readByUser(user.id).then((value) {
      value.fold((failure) {
        switch (value.runtimeType) {
          case ServerFailure:
            setMyLaundryStatus(ref, 'server error');
            break;
          case NotFoundFailure:
            setMyLaundryStatus(ref, 'Error Not Found');
            break;
          case ForbiddenFailure:
            setMyLaundryStatus(ref, 'You don\'t have access');
            break;
          case BadRequestFailure:
            setMyLaundryStatus(ref, 'Bad request');
            break;
          case UnauthorisedFailure:
            setMyLaundryStatus(ref, 'Unauthorised');
            break;
          default:
            setMyLaundryStatus(ref, 'Request error unknown');
            break;
        }
      }, (result) {
        setMyLaundryStatus(ref, 'Success');
        List data = result['data'];
        List<LaundryModel> laundries =
            data.map((e) => LaundryModel.fromJson(e)).toList();
        ref.read(myLaundryListProvider.notifier).setData(laundries);
      });
    });
  }

  @override
  void initState() {
    AppSession.getUser().then((value) {
      user = value!;
      getMyLaundry();
    });

    super.initState();
  }

  dialogClaim() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        categories(),
      ],
    );
  }

  Consumer categories() {
    return Consumer(
      builder: (_, wiRef, __) {
        String categorySelected = wiRef.watch(myLaundryCategoryProvider);
        return SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppConstants.laundryStatusCategory.length,
            itemBuilder: (context, index) {
              String category = AppConstants.laundryStatusCategory[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 30 : 8,
                  right: index == AppConstants.laundryStatusCategory.length - 1
                      ? 30
                      : 8,
                ),
                child: InkWell(
                  onTap: () {
                    setMyLaundryCategory(ref, category);
                    print('Category $category selectedis $categorySelected');
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: category == categorySelected
                            ? Colors.green
                            : Colors.grey[400]!,
                      ),
                      color: category == categorySelected
                          ? Colors.green
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      style: TextStyle(
                        height: 1,
                        color: category == categorySelected
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
      },
    );
  }

  Padding header() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 60, 30, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Laundry',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          Transform.translate(
            offset: Offset(0, -8),
            child: OutlinedButton.icon(
              onPressed: () => dialogClaim(),
              icon: Icon(Icons.add),
              label: Text(
                'Claim',
                style: TextStyle(height: 1),
              ),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.fromLTRB(8, 2, 16, 2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
