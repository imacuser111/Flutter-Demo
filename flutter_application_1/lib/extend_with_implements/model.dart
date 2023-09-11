
class ExtendA {

  String getName() => 'ExtendA';
}

class Extend extends ExtendA {
  int a;
  Extend(this.a);
}

mixin MixinA on Extend {
  @override
  String getName() => 'MixinA';
}

mixin MixinB {
  String getName() => 'MixinB';
}

class Mixin extends Extend with MixinA, MixinB implements Implements {
  Mixin(int a) : super(a);

  @override
  String implements = '123';
}

abstract class Implements {
  late String implements;

  String getName() => 'Implements';
}