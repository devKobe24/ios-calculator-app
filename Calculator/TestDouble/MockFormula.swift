//
//  MockFormula.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/06.
//


struct MockFormula<T: CalculateItem, U: CalculateItem>: FormulaProtocol {
	var operands: CalculatorItemQueue<T>
	var operators: CalculatorItemQueue<U>
	
	func result() throws -> Double {
		var calculateResult: Double = 0.0
		
		while let operands = operands.dequeue(),
			  let operators = operators.dequeue() {
			guard let operand = operands as? Double else {
				throw CalculationError.notFoundOperand
			}
			guard let `operator` = operators as? Operator else {
				throw CalculationError.notFoundOperator
			}
			
			calculateResult = `operator`.calculate(lhs: operand, rhs: calculateResult)
		}
		return calculateResult
	}
	
	init(operands: CalculatorItemQueue<T>, operators: CalculatorItemQueue<U>) {
		self.operands = operands
		self.operators = operators
	}
}
