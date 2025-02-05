import 'package:intl/intl.dart';

DateTime dateTimeFromYaml(String yamlDate) {
  DateFormat dateFormat = DateFormat('MMM d, yyyy');
  return dateFormat.parse(yamlDate);
}
