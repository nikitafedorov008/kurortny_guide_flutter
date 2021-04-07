import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'launch_url.dart';

void launchYandexTaxi(LatLng coordinates){
  launchURL('https://3.redirect.appmetrica.yandex.com/route?'
      + 'end-lat=' + '${coordinates.latitude}'
      + '&end-lon=' + '${coordinates.longitude}'
      //Идентификатор источника
      + '&ref=' + 'vibecheck'
      //Идентификатор, который определяет логику редиректа
      + '&appmetrica_tracking_id=' + '25395763362139037'
  );
}