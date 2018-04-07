import Foundation

//public static Rational toFraction(double x) {
//    // Approximate x with p/q.
//    final double eps = 0.000_001;
//    int pfound = (int) Math.round(x);
//    int qfound = 1;
//    double errorfound = Math.abs(x - pfound);
//    for (int q = 2; q < 100 && errorfound > eps; ++q) {
//        int p = (int) (x * q);
//        for (int i = 0; i < 2; ++i) { // below and above x
//            double error = Math.abs(x - ((double) p / q));
//            if (error < errorfound) {
//                pfound = p;
//                qfound = q;
//                errorfound = error;
//            }
//            ++p;
//        }
//    }
//    return new Rational(pfound, qfound);
//}

struct Fraction: CustomStringConvertible {
    let numerator: Int
    let denominator: Int
    
    var description: String {
        return "\(numerator) / \(denominator)"
    }
}

extension Double {
    func toFraction() -> Fraction {
        let eps = 0.000_001
        var numeratorFound = Int(rounded())
        var denominatorFound = 1
        var errorFound = abs(self - Double(numeratorFound))
        for denominator in 2..<100 {
            if errorFound <= eps {
                break
            }
            var numerator = Int(self * Double(denominator))
            for _ in 0..<2 {
                let error = abs(self - (Double(numerator) / Double(denominator)))
                if error < errorFound {
                    numeratorFound = numerator
                    denominatorFound = denominator
                    errorFound = error
                }
                numerator += 1
            }
        }
        return Fraction(numerator: numeratorFound, denominator: denominatorFound)
    }
}
