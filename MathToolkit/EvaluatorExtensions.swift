import MathParser

extension Evaluator {
    static var shared: Evaluator = {
        var evaluator = Evaluator()
        // TODO: register functions
        return evaluator
    }()
}
