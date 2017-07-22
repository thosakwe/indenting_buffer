# indenting_buffer
[![Pub](https://img.shields.io/pub/v/indenting_buffer.svg)](https://pub.dartlang.org/packages/indenting_buffer)
[![build status](https://travis-ci.org/thosakwe/indenting_buffer.svg)](https://travis-ci.org/thosakwe/indenting_buffer)

A StringBuffer derivative that supports indentation.

# Usage
Example of writing a nicely-formatted function:

```dart
main() {  
    var js = new IndentingBuffer()..writeln('function main() {');
    js.indent()
      ..writeln('var x = "Hello, world!";')
      ..writeln('window.alert(x);');
    js.outdent().writeln('}');
    print(js);
}
```

Output:

```js
function main() {
  var x = "Hello, world!";
  window.alert(x);
}
```

You can write text that ignores indentation:

```dart
direct() => buf.withoutIndentation('<some-text>');
```