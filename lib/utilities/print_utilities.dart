class LoggerStackTrace {

  const LoggerStackTrace._({
    required this.functionName,
    required this.callerFunctionName,
    required this.fileName,
    required this.lineNumber,
    required this.columnNumber,
  });

  factory LoggerStackTrace.from(StackTrace trace) {
    final frames             = trace.toString().split('\n');
    final functionName       = _getFunctionNameFromFrame(frames[0]);
    final callerFunctionName = _getFunctionNameFromFrame(frames[1]);
    final fileInfo           = _getFileInfoFromFrame(frames[0]);

    return LoggerStackTrace._(
      functionName:       functionName,
      callerFunctionName: callerFunctionName,
      fileName:           fileInfo[0],
      lineNumber:         int.parse(fileInfo[1]),
      columnNumber:       int.parse(fileInfo[2].replaceFirst(')', '')),
    );
  }


  final String functionName;
  final String callerFunctionName;
  final String fileName;
  final int    lineNumber;
  final int    columnNumber;


  static List<String> _getFileInfoFromFrame(String trace) {
    final indexOfFileName = trace.indexOf(RegExp('[A-Za-z]+.dart'));
    final fileInfo        = trace.substring(indexOfFileName);

    return fileInfo.split(':');
  }


  static String _getFunctionNameFromFrame(String trace) {
    final indexOfWhiteSpace = trace.indexOf(' ');
    final subStr            = trace.substring(indexOfWhiteSpace);
    final indexOfFunction   = subStr.indexOf(RegExp('[A-Za-z0-9]'));

    return subStr
        .substring(indexOfFunction)
        .substring(0, subStr.substring(indexOfFunction).indexOf(' '));
  }

  @override
  String toString() {
    return 'LoggerStackTrace('
        'functionName: $functionName, '
        'callerFunctionName: $callerFunctionName, '
        'fileName: $fileName, '
        'lineNumber: $lineNumber, '
        'columnNumber: $columnNumber)';
  }
}









String getCaller(StackTrace currentStack) {
  var stack      = currentStack.toString();
  var newLineNum = stack.indexOf("\n", 0);
  var secondLine = stack.substring(newLineNum + 9, newLineNum + 100);
  var endIndex   = secondLine.indexOf(" ", 0);
  return secondLine.substring(0, endIndex);
}


void logPrint(String content, { String?          context,
                                Map<String, int> columnWidths = const {},
                                bool             contentOnly  = false }) {

    Map<String, int> defaultColumnWidths = { "content": -1, "context": 20 };

    String output = "";

    context ??= getCaller(StackTrace.current);


    if ((columnWidths["context"] ?? defaultColumnWidths["context"]!) > -1 &&
        context.length > (columnWidths["context"] ?? defaultColumnWidths["context"]!)) {

        output += "${context.substring(0, ((columnWidths["context"] ?? defaultColumnWidths["context"]!) - 3))}...";

    } else {
        output += context + (" " * ((columnWidths["context"] ?? defaultColumnWidths["context"]!) - context.length));
    }


    output += " | ";


    if ((columnWidths["content"] ?? defaultColumnWidths["content"]!) > -1 &&
        content.length > (columnWidths["content"] ?? defaultColumnWidths["content"]!)) {

        output += "${content.substring(0, ((columnWidths["content"] ?? defaultColumnWidths["content"]!) - 3))}...";

    } else {
        output += content + (" " * ((columnWidths["content"] ?? defaultColumnWidths["content"]!) - content.length));
    }


    print(output);
}