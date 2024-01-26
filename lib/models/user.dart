import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

  Map<String, dynamic> toMap() { // return a map of String, dynamic ex => 'name': "hussein"
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  //this create a new instant of user from Map<String, dynamic>
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '', // ?? is null-aware operator which returns the left-hand operand if it's not null otherwise the right-hand operand
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(//This part converts the resulting iterable of Map<String, dynamic> objects into a list of the same type
        map['cart']?.map((x) => Map<String, dynamic>.from(x), // map method on the cart property of the map. The ?. operator is the null-aware access, which only calls map if map['cart'] is not null For each element x in the cart list, it converts it to a Map<String, dynamic> using the from constructor
        ),
      ),
    );
  }
  // Method to serialize the user object to JSON
  String toJson() => json.encode(toMap());
  // Factory method to create a user object from JSON
  factory User.fromJson(String source) => User.fromMap(json.decode(source));


  //because in dart strings and numbers are immutable values cannot be changed after they are created
  //he copyWith method allows you to create a new User object with updated properties without modifying the original object.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }

}
