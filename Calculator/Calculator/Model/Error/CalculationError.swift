//
//  CalculationError.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/14.
//

enum CalculationError: Error {
	case notFoundOperand
	case notFoundOperator
	case indexOutOfRange
	case divideByZero
	case unknown
	
	var message: String {
		switch self {
		case .notFoundOperand:
			return "피연산자를 찾을 수 없습니다."
		case .notFoundOperator:
			return "연산자를 찾을 수 없습니다."
		case .indexOutOfRange:
			return "범위를 벗어난 접근입니다."
		case .divideByZero:
			return "0으로 나눌 수 없습니다."
		case .unknown:
			return "알 수 없는 오류입니다."
		}
	}
}
