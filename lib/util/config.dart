// UI CONST
const double DEVICE_WIDTH = 1080;
const double DEVICE_HEIGHT = 1920;

// NETWORK
const String BACKEND_URL = 'http://194.146.43.98:4000';

// DOCTORS CATEGORIES
const List<Map> DOCTOR_CATEGORIES = [
  {'value': 'Акушер-гинекологи', 'id': 0},
  {'value': 'Эндокринологи', 'id': 1},
  {'value': 'Психологи/Психотерапевты', 'id': 2},
  {'value': 'Педиатры', 'id': 3},
  {'value': 'Аллергологи', 'id': 4},
];

enum HttpStatus { Success, Error }

const List<String> MONTH_NAME = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь'
];

const List<String> DAYS_NAME = [
  'ПН',
  'ВТ',
  'СР',
  'ЧТ',
  'ПТ',
  'СБ',
  'ВС',
];
