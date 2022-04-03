import 'package:graphql_schema2/graphql_schema2.dart';
import 'package:angel3_serialize/angel3_serialize.dart';

@GraphQLDocumentation(description: 'Any object with a .text (String) property.')
abstract class HasText {
  String? get text;
}

@serializable
@GraphQLDocumentation(description: 'List of all the unavailable days')
class UnavailableDays implements HasText {
  @override
  String? text;

  @GraphQLDocumentation(deprecationReason: 'Use `day` instead.')
  List<String>? days;

  UnavailableDays({this.days});
}

@serializable
@GraphQLDocumentation(description: 'List of days with LOS period')
class Los implements HasText {
  @override
  String? text;

  @GraphQLDocumentation(description: 'List of LOS days')
  List<Day>? losDay;

  Los({this.losDay});
}

@serializable
@GraphQLDocumentation(description: 'Los day object')
class Day implements HasText {
  @override
  String? text;

  @GraphQLDocumentation(deprecationReason: 'Use `day` instead.')
  String? day;

  @GraphQLDocumentation(deprecationReason: 'Use `LOS` instead.')
  String? los;

  Day({this.day, this.los});
}
