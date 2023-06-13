//
//  Operator+Extension.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/09.
//

extension Operator: CalculateItem {
	static var all: [Character] {
		return Self.allCases.map { $0.rawValue }
	}
	
	func calculate(lhs: Double, rhs: Double) -> Double {
		switch self {
		case .add:
			return add(lhs: lhs, rhs: rhs)
		case .subtract:
			return subtract(lhs: lhs, rhs: rhs)
		case .divide:
			return divide(lhs: lhs, rhs: rhs)
		case .multiply:
			return multiply(lhs: lhs, rhs: rhs)
		}
	}
	
	private func add(lhs: Double, rhs: Double) -> Double {
		return lhs + rhs
	}
	
	private func subtract(lhs: Double, rhs: Double) -> Double {
		return lhs - rhs
	}
	
	private func divide(lhs: Double, rhs: Double) -> Double {
		return lhs / rhs
	}
	
	private func multiply(lhs: Double, rhs: Double) -> Double {
		return lhs * rhs
	}
}
