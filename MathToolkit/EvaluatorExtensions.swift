import MathParser
import Foundation

extension Evaluator {
    static var shared: Evaluator = {
        var evaluator = Evaluator()
        
        return evaluator
    }()
}

func approxEqImpl(state: EvaluationState) throws -> Double {
    if state.arguments.count != 2 {
        throw MathParserError(kind: .invalidArguments, range: Range(0...0))
    }
    let lhs = try state.evaluator.evaluate(state.arguments.first!, substitutions: state.substitutions)
    let rhs = try state.evaluator.evaluate(state.arguments[1], substitutions: state.substitutions)
    return (abs(lhs - rhs) < 0.00000000001) ? 1 : 0
}
