class Expense {
  String name;
  String description;
  String date;
  double amount;
  String type;
  String? imageUrl;

  Expense({
    required this.name,
    required this.description,
    required this.date,
    required this.amount,
    required this.type,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'amount': amount,
      'type': type,
      'imageUrl': imageUrl,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      name: map['name'],
      description: map['description'],
      date: map['date'],
      amount: map['amount'],
      type: map['type'],
      imageUrl: map['imageUrl'],
    );
  }
}
