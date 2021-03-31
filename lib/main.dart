import 'package:flutter/material.dart';
import 'package:kurortny_guide_flutter/pages/home_page.dart';

/*
 __  __                              __
/\ \/\ \                            /\ \__                 __
\ \ \/'/'  __  __  _ __   ___   _ __\ \ ,_\   ___   __  __/\_\
 \ \ , <  /\ \/\ \/\`'__\/ __`\/\`'__\ \ \/ /' _ `\/\ \/\ \/\ \
  \ \ \\`\\ \ \_\ \ \ \//\ \L\ \ \ \/ \ \ \_/\ \/\ \ \ \_\ \ \ \  Kurortnyi
   \ \_\ \_\ \____/\ \_\\ \____/\ \_\  \ \__\ \_\ \_\/`____ \ \_\
    \/_/\/_/\/___/  \/_/ \/___/  \/_/   \/__/\/_/\/_/`/___/> \/_/
                                                        /\___/
                                                        \/__/
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Курортный район',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(title: 'Курортный район'),
    );
  }
}