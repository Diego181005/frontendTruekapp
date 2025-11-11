import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart'; // ✅ Importa Sizer

import 'routes.dart';
import 'providers/auth_provider.dart';
import 'providers/listing_provider.dart';
import 'providers/trade_provider.dart';
import 'providers/review_provider.dart';
import 'providers/wallet_provider.dart';
import 'providers/settings_provider.dart';

void main() {
  runApp(const TruekApp());
}

class TruekApp extends StatelessWidget {
  const TruekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ListingProvider()),
        ChangeNotifierProvider(create: (_) => TradeProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Sizer(
        // ✅ Envuelve MaterialApp en Sizer
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TruekApp',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              useMaterial3: true,
            ),
            initialRoute: AppRoutes.login,
            routes: AppRoutes.routes,
              // No se debe añadir `baseUrl` aquí: MaterialApp no tiene esa propiedad.
              // La URL base se configura en `lib/services/api_client.dart`.
          );
        },
      ),
    );
  }
}
