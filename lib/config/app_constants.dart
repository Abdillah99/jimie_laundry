import 'package:flutter/material.dart';
import 'package:jimie_laundry/pages/dashboard_views/account_view.dart';
import 'package:jimie_laundry/pages/dashboard_views/home_view.dart';
import 'package:jimie_laundry/pages/dashboard_views/my_laundry_view.dart';

class AppConstants {
  static const appName = 'Jimie Laundry';
  static const _host = 'http://localhost:8000';
  static const baseURL = '$_host/api';
  static const baseImageURL = '$_host/storage';

  static const laundryStatusCategory = [
    'All',
    'Pickup',
    'Queue',
    'Process',
    'Washing',
    'Dried',
    'Ironed',
    'Done',
    'Delivery'
  ];

  static List<Map> navMenuDashboard = [
    {
      'view': const HomeView(),
      'icon': Icons.home_filled,
      'label': 'Home',
    },
    {
      'view': const MyLaundryView(),
      'icon': Icons.local_laundry_service,
      'label': 'My Laundry',
    },
    {
      'view': const AccountView(),
      'icon': Icons.account_circle,
      'label': 'Account',
    },
  ];

  static const homeCategories = [
    'All',
    'Regular',
    'Express',
    'Economical',
    'Exclusive',
  ];
}
