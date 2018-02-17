#  装饰模式

简介：
        标准的装饰模式有包括一个抽象的Component父类，它声明了一些操作，它具体的类讲进行重载以实现自己特定的操作。这个
        Component具体类是模式中的被装饰者，Component父类可以被细化为另一个叫做Decorator的抽象类，即装饰者抽象类。Decorator
        类中包含了一个Component的引用。Decorator的具体类为Component或者Decorator定义了几个扩展行为，并且会在自己的操作中内
        嵌Component操作.
        Component定义了一些抽象操作，具体类将进行重载实现自己特定的操作。Decorator抽象类通过将一个Component（或Decorator）
        内嵌到Decorator对象，定义了扩展这个Component的实例的“装饰性”的行为.
        默认的operation方法只是想内嵌的Component发送一个消息，Decorator的具体实现类重载父类的operation，通过super把自己增加的
        行为扩展给Component的operation。如果只需要向Component添加一种职责，那可以省掉抽象的Decorator类，让具体的Decorator直
        接把请求转发给Component.
        
应用场景：
        1.想要在不影响其他对象的情况下，以动态、透明的方式给单个对象添加职责.
        2.想要扩展一个类的行为，却做不到。类定义可能被隐藏，无法进行子类化；或者对类的每个行为的扩展，为支持每种功能组合，将产
        生大量的子类.
        3.对类的职责的扩展是可选的.
        4.装饰者子类必须持有被装饰原类对象



