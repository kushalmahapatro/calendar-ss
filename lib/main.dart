import 'package:intl/date_symbol_data_local.dart';
import 'package:stella_stays/screen/booking/view/booking_view.dart';
import 'package:stella_stays/stella_stays.dart';

import 'package:stella_stays/utils/graphql_provider.dart';

void main() async {
  await initHiveForFlutter();

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

String get host {
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      return '10.0.2.2';
    } else {
      return '127.0.0.1';
    }
  } else {
    return '127.0.0.1';
  }
}

final graphqlEndpoint = 'http://$host:3000/graphql';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GraphQLProvider(
        client: clientFor(uri: graphqlEndpoint),
        child: MaterialApp(
          title: 'TableCalendar Example',
          theme: SSTheme.theme,
          home: const BookingView(),
        ),
      ),
    );
  }
}
