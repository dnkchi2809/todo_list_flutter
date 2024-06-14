import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String statusByLocale(context, String value) {
  String valueByLocale;
  switch (value) {
    case "To do":
      valueByLocale = AppLocalizations.of(context)!.toDo;
      break;
    case "In progress":
      valueByLocale = AppLocalizations.of(context)!.inProgress;
      break;
    case "Pending":
      valueByLocale = AppLocalizations.of(context)!.pending;
      break;
    case "Done":
      valueByLocale = AppLocalizations.of(context)!.done;
      break;
    default:
      valueByLocale = AppLocalizations.of(context)!.all;
      break;
  }
  return valueByLocale;
}
