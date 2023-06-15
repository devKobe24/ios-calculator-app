//
//  CalculatorManager.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/15.
//

extension ViewController {
	final class CalculatorManager {
		private var expression: String = ""
		
		func inputOperand(_ element: String) -> String {
			return OperandFormatter.formatInput(element)
		}
	}
}
