import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

final debugLogPrintProvider = Provider<SimpleLogger>((_) {
  final logger = SimpleLogger();
  logger.setLevel(
    Level.ALL,
    includeCallerInfo: true,
  );
  logger.formatter = (info) {
    String time = info.time.toString().substring(11, 23);
    Map<Level, String> levelPrefixes = {
      Level.FINEST: '☺️',
      Level.FINER: '☀️',
      Level.FINE: '✌️️',
      Level.CONFIG: '✂️',
      Level.INFO: '☕️',
      Level.WARNING: '‼️',
      Level.SEVERE: '☔️',
      Level.SHOUT: '😡',
    };
    String emoji = levelPrefixes[info.level].toString();
    return '[$emoji️ $time|${info.callerFrame!.uri}:${info.callerFrame!.line}:${info.callerFrame!.column}]${info.message}';
  };
  return logger;
});