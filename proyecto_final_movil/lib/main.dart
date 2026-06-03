import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'widgets/auth_wrapper.dart';
import 'widgets/offline_sync_banner.dart';
import 'data/local/database.dart';
import 'services/connectivity_service.dart';
import 'services/sync_service.dart';
import 'repositories/user_repository.dart';
import 'repositories/offer_repository.dart';
import 'repositories/postulation_repository.dart';
import 'repositories/document_repository.dart';
import 'repositories/follow_up_repository.dart';
import 'repositories/company_repository.dart';
import 'services/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar base de datos local (Drift/SQLite)
  final database = AppDatabase();
  
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        Provider<ConnectivityService>(create: (_) => ConnectivityService()),
        ProxyProvider<AppDatabase, SyncService>(
          update: (_, db, __) => SyncService(db)..initialize(),
          dispose: (_, service) => service.dispose(),
          lazy: false,
        ),
        ProxyProvider<AppDatabase, UserRepository>(
          update: (_, db, __) => UserRepository(db),
        ),
        ProxyProvider<AppDatabase, OfferRepository>(
          update: (_, db, __) => OfferRepository(db),
        ),
        ProxyProvider<AppDatabase, PostulationRepository>(
          update: (_, db, __) => PostulationRepository(db),
        ),
        ProxyProvider<AppDatabase, DocumentRepository>(
          update: (_, db, __) => DocumentRepository(db),
        ),
        ProxyProvider<AppDatabase, FollowUpRepository>(
          update: (_, db, __) => FollowUpRepository(db),
        ),
        ProxyProvider<AppDatabase, CompanyRepository>(
          update: (_, db, __) => CompanyRepository(db),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) {
              SessionManager().resetTimer(context);
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Proyecto Final Móvil',
              builder: (context, child) {
                return Column(
                  children: [
                    const OfflineSyncBanner(),
                    Expanded(child: child ?? const SizedBox.shrink()),
                  ],
                );
        },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          home: AuthWrapper(),
      ), // MaterialApp
    ); // Listener
  },
), // Builder
    ); // MultiProvider
  }
}
