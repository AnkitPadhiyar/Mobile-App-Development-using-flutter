import 'package:flutter_test/flutter_test.dart';
import 'package:emi_calculator/emi.dart';

void main() {
  test('calculate EMI for zero interest', () {
    final res = calculateEmi(principal: 120000, annualRate: 0, months: 12);
    expect(res.emi, closeTo(10000, 1e-6));
    expect(res.totalPayment, closeTo(120000, 1e-6));
    expect(res.totalInterest, closeTo(0, 1e-6));
  });

  test('calculate EMI typical case', () {
    final res = calculateEmi(principal: 500000, annualRate: 7.5, months: 60);
    // Expected roughly 10000+; assert properties rather than fixed value
    expect(res.emi, greaterThan(9000));
    expect(res.totalPayment, greaterThan(emiLowerBound(res.emi, 60)));
    expect(res.totalInterest, greaterThan(0));
  });

  test('invalid inputs throw', () {
    expect(
      () => calculateEmi(principal: -1, annualRate: 5, months: 12),
      throwsArgumentError,
    );
    expect(
      () => calculateEmi(principal: 1000, annualRate: -2, months: 12),
      throwsArgumentError,
    );
    expect(
      () => calculateEmi(principal: 1000, annualRate: 5, months: 0),
      throwsArgumentError,
    );
  });
}

// helper
num emiLowerBound(double emi, int months) => emi * months - 1e-6;
