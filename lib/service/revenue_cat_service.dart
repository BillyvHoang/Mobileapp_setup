import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevenueCatService {
  static const _apiKey = '';

  Future<void> init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(_apiKey));
  }

  Future<void> login(String userId) async {
    await Purchases.logIn(userId);
  }

  Future<List<Package>> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.current?.availablePackages ?? [];
    } catch (e) {
      print('Error fetching offerings: $e');
      return [];
    }
  }

  Future<bool> purchasePackage(Package package) async {
    try {
      final purchaserInfo = await Purchases.purchasePackage(package);
      return purchaserInfo.entitlements.all['your_entitlement_id']?.isActive ?? false;
    } catch (e) {
      print('Error making purchase: $e');
      return false;
    }
  }
}

final revenueCatServiceProvider = Provider((ref) => RevenueCatService());