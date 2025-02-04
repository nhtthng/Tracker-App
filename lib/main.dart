import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker_app/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(brightness: Brightness.light,seedColor: const Color.fromARGB(255, 96, 59, 181));
var kDarkColorScheme = ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: const Color.fromARGB(255, 5, 99, 125));
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn){
    runApp(
     MaterialApp(
      darkTheme: ThemeData.dark().copyWith(useMaterial3: true, colorScheme: kDarkColorScheme,appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kDarkColorScheme.onPrimaryContainer,
        foregroundColor: kDarkColorScheme.primaryContainer,
        
      ),
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: kDarkColorScheme.primaryContainer,foregroundColor: kDarkColorScheme.onPrimaryContainer)),
      ),
      theme: ThemeData().copyWith(useMaterial3: true, colorScheme: kColorScheme,appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: kColorScheme.primaryContainer)),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge:  TextStyle(fontWeight: FontWeight.bold,color: kColorScheme.onSecondaryContainer, fontSize: 16,)
      )
      ),
      themeMode: ThemeMode.system, // mình có thể set chủ đề dark hoặc light, nhưng mà nên đi theo hệ thống mà người dùng đang sử dụng
      home: const Expenses(),
    ),
  );
  });
  
}