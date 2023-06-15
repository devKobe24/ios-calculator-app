//
//  ButtonTypeEnum.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/14.
//

typealias ExpressionValues = (operandValue: String, operatorValue: String)



enum ButtonType {
	case allClear
	case cleaeEntry
	case toggleSign
	case equal
	case dot
	case doubleZero
	case operators
	case numbers
	
	static func getType(_ button: String) -> ButtonType {
		let operators: [String] = Operator.allCases.map { String($0.rawValue) }
		
		switch button {
		case CalculateNamespace.allClear:
			return .allClear
		case CalculateNamespace.clearEntry:
			return .cleaeEntry
		case CalculateNamespace.toggleSign:
			return .toggleSign
		case CalculateNamespace.equal:
			return .equal
		case CalculateNamespace.dot:
			return .dot
		case CalculateNamespace.doubleZero:
			return .doubleZero
		default:
			if operators.contains(button) {
				return .operators
			}
			return .numbers
		}
	}
}
