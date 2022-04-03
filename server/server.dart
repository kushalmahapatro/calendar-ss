// ignore_for_file: deprecated_member_use
import 'package:angel3_cors/angel3_cors.dart';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_framework/http.dart';
import 'package:angel3_graphql/angel3_graphql.dart';
import 'package:graphql_schema2/graphql_schema2.dart';
import 'package:graphql_server2/graphql_server2.dart';
import 'package:graphql_server2/mirrors.dart';
import 'package:logging/logging.dart';
import 'package:angel3_container/mirrors.dart';
import 'package:stella_stays_gql/data.dart';
import 'package:stella_stays_gql/model.dart';

void main() async {
  var logger = Logger('stella_stays');
  var app = Angel(
      logger: logger
        ..onRecord.listen((rec) {
          print(rec);
          if (rec.error != null) print(rec.error);
          if (rec.stackTrace != null) print(rec.stackTrace);
        }),
      reflector: MirrorsReflector());
  var http = AngelHttp(app);
  HookedService mountService<T>(
    Angel app,
    String path, {
    bool managed = false,
  }) {
    final service = MapService(
        // autoIdAndDateFields: managed,
        // autoSnakeCaseNames: false,
        );
    final hooked = app.use(path, service);
    return hooked;
  }

  var unavaialbelDaysService =
      mountService<UnavailableDays>(app, 'api/days/unavailable');
  var losDaysService = mountService<Los>(app, 'api/days/los');

  var queryType = objectType(
    'Query',
    description: 'A simple API that get the unavailable and los day lists',
    fields: [
      field(
        'unavailable_days',
        listOf(convertDartType(UnavailableDays)!.nonNullable()),
        resolve: resolveViaServiceIndex(unavaialbelDaysService),
      ),
      field(
        'los_days',
        listOf(convertDartType(Los)!.nonNullable()),
        resolve: resolveViaServiceIndex(losDaysService),
        // inputs: [
        //   GraphQLFieldInput('id', graphQLId.nonNullable()),
        // ],
      ),
    ],
  );

  var mutationType = objectType(
    'Mutation',
    description: 'Modify the lists',
    fields: [
      field(
        'addUnavailableDay',
        convertDartType(String)!,
        inputs: [
          GraphQLFieldInput(
              'data', convertDartType(String)!.coerceToInputObject()),
        ],
        resolve: resolveViaServiceCreate(unavaialbelDaysService),
      ),
    ],
  );

  var schema = graphQLSchema(
    queryType: queryType,
    mutationType: mutationType,
  );
  app.fallback(cors());
  app.all('/graphql', graphQLHttp(GraphQL(schema)));
  app.get('/graphiql', graphiQL());

  CorsOptions(origin: '*');

  Map<String, dynamic> udm = <String, dynamic>{};
  udm['text'] = "unavailable days";
  List<String> days = <String>[];
  for (String ud in data['unavailable_days'] as List) {
    days.add(ud);
  }
  udm['days'] = days;
  await unavaialbelDaysService.create(udm);

  Map<String, dynamic> losm = <String, dynamic>{};
  losm['text'] = "los days";
  List<Map<String, dynamic>> day = <Map<String, dynamic>>[];

  for (Map<String, dynamic> los in data['los'] as List) {
    day.add(los);
  }
  losm['los_day'] = day;

  await losDaysService.create(losm);

  var server = await http.startServer('127.0.0.1', 3000);
  var uri =
      Uri(scheme: 'http', host: server.address.address, port: server.port);
  var graphiqlUri = uri.replace(path: 'graphiql');
  print('Listening at $uri');
  print('Access graphiql at $graphiqlUri');
}
