import 'package:wmn_plus/features/fertility_calendar/index.dart';

class FertilityCalendarRepository {
  final FertilityCalendarProvider _fertilityCalendarProvider = FertilityCalendarProvider();

  FertilityCalendarRepository();
  
  getFertilityDays() => _fertilityCalendarProvider.getRequestFertilityDays();
}