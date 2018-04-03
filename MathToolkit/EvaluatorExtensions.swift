import MathParser
import Foundation

extension Evaluator {
    static var shared: Evaluator = {
        var evaluator = Evaluator()
        
        return evaluator
    }()
}
