import 'file:///D:/Flutter%20Projects/ecommerce_app/lib/Services/firestore_service.dart';
import 'package:ecommerce_app/providers/FirebaseProvider.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/data_getter_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/providers/image_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  await Firebase.initializeApp();
  final FirestoreService _db = FirestoreService();
  final auth_provider auth = auth_provider();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => auth_provider()),
      ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
      ChangeNotifierProvider(create: (context) => data_getter_provider()),
      ChangeNotifierProvider(create: (context) => FirebaseProvider()),
      ChangeNotifierProvider(create: (context) => Custom_Provider()),
      StreamProvider(create: (context) => _db.getCategories()),
      StreamProvider(create: (context) => _db.getopsalesproducts()),
      //FutureProvider(create: (context) => auth.GetUser())

      //StreamProvider(create: (context) => _db.getcartLength()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<auth_provider>(context, listen: false);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: GoogleFonts.ptSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: authprovider.check_auth());
  }
}
