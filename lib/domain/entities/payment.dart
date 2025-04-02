class Payment {
  final String phoneNumber;
  final double amount;
  final String businessCode;
  final String reference;
  final String description;

  Payment({
    required this.phoneNumber,
    required this.amount,
    this.businessCode = "174379",
    this.reference = "Test Payment",
    this.description = "Test Payment",
  });
}