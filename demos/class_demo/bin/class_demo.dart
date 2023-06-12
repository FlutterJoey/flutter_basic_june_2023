import 'package:class_demo/class_demo.dart';

void main(List<String> arguments) {
  var dog = Labrador(name: 'Fido', age: 12);

  print(dog.speak());
  dog.kill();
  print(dog.speak());
}
