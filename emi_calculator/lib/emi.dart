import 'dart:math' show pow;

class EmiResult {
  final double emi;
  final double totalPayment;
  final double totalInterest;

  EmiResult(this.emi, this.totalPayment, this.totalInterest);
}

/// Calculate EMI given principal, annual rate (%) and tenure in months.
EmiResult calculateEmi({
  required double principal,
  required double annualRate,
  required int months,
}) {
  if (months <= 0) throw ArgumentError('months must be > 0');
  if (principal < 0) throw ArgumentError('principal cannot be negative');
  if (annualRate < 0) throw ArgumentError('annualRate cannot be negative');

  final monthlyRate = annualRate / 12 / 100;
  double emi;
  if (monthlyRate == 0) {
    emi = principal / months;
  } else {
    final r = monthlyRate;
    final numerator = principal * r * pow(1 + r, months);
    final denominator = pow(1 + r, months) - 1;
    emi = numerator / denominator;
  }

  final totalPayment = emi * months;
  final totalInterest = totalPayment - principal;
  return EmiResult(emi, totalPayment, totalInterest);
}
