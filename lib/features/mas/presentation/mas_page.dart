import 'package:flutter/material.dart';
import 'package:multas_app/features/settings/configuration_page.dart';
import 'package:multas_app/features/settings/presentation/privacy/privacy_view.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';

class AdemasPageApp extends StatefulWidget {
  const AdemasPageApp({super.key});
  @override
  AdemasPageAppState createState() => AdemasPageAppState();
}

class AdemasPageAppState extends State<AdemasPageApp> {
  RateMyApp rateMyApp = RateMyApp(
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // googlePlayIdentifier: '',
    // appStoreIdentifier: '',
  );

  // @override
  // void initState() {
  //   super.initState();
  //   rateMyApp.init().then(
  //     (_) {
  //       //  if (rateMyApp.shouldOpenDialog) {
  //       rateMyApp.showStarRateDialog(
  //         context,
  //         title: 'Califica esta aplicación', // The dialog title.
  //         message:
  //             '¿Te gusta esta aplicación? Entonces dedica un poco de tu tiempo a dejar una valoración:', // The dialog message.
  //         // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
  //         actionsBuilder: (context, stars) {
  //           // Triggered when the user updates the star rating.
  //           return [
  //             // Return a list of actions (that will be shown at the bottom of the dialog).
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () async {
  //                 print('Thanks for the ' +
  //                     (stars == null ? '0' : stars.round().toString()) +
  //                     ' star(s) !');
  //                 // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
  //                 // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
  //                 await rateMyApp
  //                     .callEvent(RateMyAppEventType.rateButtonPressed);
  //                 Navigator.pop<RateMyAppDialogButton>(
  //                     context, RateMyAppDialogButton.rate);
  //               },
  //             ),
  //           ];
  //         },
  //         ignoreNativeDialog: Platform
  //             .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
  //         dialogStyle: const DialogStyle(
  //           // Custom dialog styles.
  //           titleAlign: TextAlign.center,
  //           messageAlign: TextAlign.center,
  //           messagePadding: EdgeInsets.only(bottom: 20),
  //         ),
  //         starRatingOptions:
  //             const StarRatingOptions(), // Custom star bar rating options.
  //         onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
  //             .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
  //       );
  //       // }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Ayuda y Configuración'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstScreen()),
                );
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.question_answer),
            //   title: Text('Atención al cliente'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => FirstScreen()),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.star),
            //   title: const Text('Nos califica'),
            //   onTap: () {
            //     // print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
            //     // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
            //     // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
            //     rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
            //     Navigator.pop<RateMyAppDialogButton>(
            //         context, RateMyAppDialogButton.rate);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Compartir'),
              onTap: () {
                SharePlus.instance.share(
                  ShareParams(
                    uri: Uri.parse(
                      'https://play.google.com/store/search?q=pub%3ADivTag&c=apps',
                    ),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.help),
            //   title: const Text('Preguntar'),
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => const AdemasPageApp()),
            //     // );
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.android_rounded),
              title: const Text('Politica de privacidad'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacyView()),
                );
              },
            ),
          ],
        ),
      );
}
