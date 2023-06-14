//
//  Formula.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/06.
//

struct Formula<T: CalculateItem, U: CalculateItem>: FormulaProtocol {
	var operands: CalculatorItemQueue<T>
	var operators: CalculatorItemQueue<U>
	
	mutating func result() throws -> Double {
		guard var result = operands.dequeue() as? Double else {
			throw CalculationError.notFoundOperand
		}
		guard var isOperandsEmpty = operands.isEmpty else {
			throw CalculationError.notFoundOperand
		}
		while !isOperandsEmpty {
			guard let `operator` = operators.dequeue() as? Operator else {
				throw CalculationError.notFoundOperator
			}
			guard let nextOperand = operators.dequeue() as? Double else {
				throw CalculationError.notFoundOperand
			}
			result = `operator`.calculate(lhs: result, rhs: nextOperand)
		}
		return result
	}
	
	init(operands: CalculatorItemQueue<T>, operators: CalculatorItemQueue<U>) {
		self.operands = operands
		self.operators = operators
	}
}
