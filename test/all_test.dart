import 'package:indenting_buffer/indenting_buffer.dart';
import 'package:test/test.dart';

main() {
  test('indent+outdent', () {
    var js = new IndentingBuffer()..writeln('function main() {');
    js.indent()
      ..writeln('var x = "Hello, world!";')
      ..writeln('window.alert(x);');
    js.outdent().writeln('}');
    print(js);
    expect(js.toString(),
        'function main() {\n  var x = "Hello, world!";\n  window.alert(x);\n}\n');
  });

  test('outdent limit', () {
    var buf = new IndentingBuffer().outdent().outdent().outdent();
    buf.write('a');
    expect(buf.toString(), 'a');
  });

  test('clear', () {
    var buf = new IndentingBuffer()
      ..writeln('abcdjwnonoeinvoinqoinpqiv')
      ..clear();
    expect(buf, isEmpty);
    expect(buf.toString(), isEmpty);
  });

  test('custom space+newline', () {
    var buf = new IndentingBuffer(space: ':)', newline: '\n');
    buf.indent().indent().writeln('ok');
    buf.outdent().writeln('ok');
    buf.outdent().writeln('ok');
    print(buf);
    expect(buf.toString(), ':):)ok\n:)ok\nok\n');
  });
}
