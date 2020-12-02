## Install on mac


``` shell
brew tap dart-lang/dart
brew install dart
```

``` shell
pub global activate stagehand
```

add 

``` shell
export PATH="$PATH":"$HOME/.pub-cache/bin"
```
to `~/.zshe`

``` shell
mkdir dart_hw
cd dart_hw
```

### Edit file

Create file  `hello.dart`:]

``` dart
import 'name.dart' as name;

void main(List<String> arguments) {
  print('Hello ${name.getName()}!');
}
```

And `name.dart`:

``` dart
String getName() {
  return "Bartek";
}
```

Then run:

``` shell
dart hello.dart
```

* <https://dart.dev/tutorials/server/get-started>
