class Organism {
  Organism({
    required this.type,
    required this.isAlive,
  });

  final String type;
  bool isAlive;

  void kill() {
    isAlive = false;
  }
}

class Animal extends Organism {
  final int age;

  Animal({
    super.type = 'Animal',
    super.isAlive = true,
    required this.age,
  });
}

class Dog extends Animal {
  String name;
  Dog({
    required this.name,
    required super.age,
  }) : super(isAlive: true, type: 'Dog');
}

class Labrador extends Dog {
  Labrador({required super.name, required super.age});

  String speak() {
    if (!isAlive) {
      return '---';
    }
    return 'Hi i am an $type and my name is $name and I am $age years old';
  }
}

enum RpsType {
  rock(winsFrom: 2),
  paper(winsFrom: 0),
  scissors(winsFrom: 1);

  final int winsFrom;

  const RpsType({
    required this.winsFrom,
  });

  bool wins(RpsType other) {
    return winsFrom == other.index;
  }
}
