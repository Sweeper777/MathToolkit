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
