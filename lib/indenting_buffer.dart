import 'package:charcode/charcode.dart';

/// A StringBuffer derivative that supports identation.
class IndentingBuffer implements StringBuffer {
  final List<int> _buf = [];
  List<int> _crlf;
  String _cache;
  int _level = 0;

  /// The [String] used to write newlines. Default: `'\r\n'`.
  String newline;

  /// The [String] used to indent text. Default: `'  '`.
  String space;

  IndentingBuffer({this.space, this.newline}) {
    space ??= '  ';
    _crlf = newline?.codeUnits ?? [$cr, $lf];
  }

  /// The level of indentation this buffer is currently set to.
  int get indentationLevel => _level;

  @override
  bool get isNotEmpty => _buf.isNotEmpty;

  @override
  bool get isEmpty => _buf.isEmpty;

  @override
  int get length => _buf.length;

  /// Increments the [indentationLevel].
  IndentingBuffer indent() {
    _level++;
    return this;
  }

  /// Decrements the [indentationLevel], if it is greater than 0.
  IndentingBuffer outdent() {
    if (_level > 0) _level--;
    return this;
  }

  /// Writes a value, without heeding the [indentationLevel].
  void withoutIndent(Object obj) {
    _cache = null;
    _buf.addAll(obj.toString().codeUnits);
  }

  @override
  void clear() {
    _cache = null;
    _buf.clear();
  }

  @override
  void writeln([Object obj = ""]) {
    if (obj != null)
      write(obj);
    else
      _cache = null;
    _buf.addAll(_crlf);
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    write(objects.join(separator ?? ''));
  }

  @override
  void writeCharCode(int charCode) {
    _cache = null;
    _buf.add(charCode);
  }

  @override
  void write(Object obj) {
    _cache = null;
    for (int i = 0; i < _level; i++) _buf.addAll(space.codeUnits);
    _buf.addAll(obj.toString().codeUnits);
  }

  @override
  String toString() {
    return _cache ??= new String.fromCharCodes(_buf);
  }
}
