// Path: lib/features/auth/presentation/pages/subscription_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp_setup/features/auth/presentation/page/login_page.dart';
import 'package:mobileapp_setup/service/revenue_cat_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPage extends ConsumerStatefulWidget {
  const SubscriptionPage({super.key});

  @override
  SubscriptionPageState createState() => SubscriptionPageState();
}

class SubscriptionPageState extends ConsumerState<SubscriptionPage> {
  List<Package> _packages = [];

  @override
  void initState() {
    super.initState();
    _fetchOfferings();
  }

  Future<void> _fetchOfferings() async {
    final packages = await ref.read(revenueCatServiceProvider).getOfferings();
    if (mounted) {
      setState(() {
        _packages = packages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Subscription')),
      body: _packages.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _packages.length,
              itemBuilder: (context, index) {
                final package = _packages[index];
                return _buildSubscriptionOption(package);
              },
            ),
    );
  }

  Widget _buildSubscriptionOption(Package package) {
    return Card(
      child: ListTile(
        title: Text(package.storeProduct.title),
        subtitle: Text(package.storeProduct.description),
        trailing: Text(package.storeProduct.priceString),
        onTap: () => _handleSubscription(package),
      ),
    );
  }

  Future<void> _handleSubscription(Package package) async {
    final success = await ref.read(revenueCatServiceProvider).purchasePackage(package);
    if (mounted) {
      _handleSubscriptionResult(success);
    }
  }

  void _handleSubscriptionResult(bool success) {
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subscription successful!')),
      );
      // Navigate to the LoginPage after successful subscription
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subscription failed. Please try again.')),
      );
    }
  }
}