//
//  OperandFormatter.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/14.
//

import Foundation

enum OperandFormatter {
	static func formatStringOperand(_ operand: String) -> String {
		let operandNumber = NSDecimalNumber(string: operand)
		return formatNumberToString(operandNumber)
	}
	
	//MARK: - 코드해석 필요
	static func formatInput(_ operand: String) -> String {
		guard let firstDigit = operand.first,
			  !operand.contains(",") else {
			return operand
		}
		var newOperand: String = operand
		var sign: String = CalculateNamespace.empty
		
		if String(firstDigit) == CalculateNamespace.negative {
			newOperand = String(newOperand.dropFirst(1))
			sign = CalculateNamespace.negative
		}
		
		if newOperand.count > 20 {
			newOperand = String(newOperand.prefix(20))
		}
		
		newOperand = sign + newOperand
		let operandSplit = newOperand.components(separatedBy: CalculateNamespace.dot)
		
		guard let operandInteger = operandSplit.first,
			  let operandFraction = operandSplit.last else {
			return newOperand
		}
		let operandDouble = NSDecimalNumber(string: operandInteger)
		newOperand = formatNumberToString(operandDouble)
		
		if operandSplit.count == 2 {
			newOperand += CalculateNamespace.dot + operandFraction
		}
		return newOperand
		
	}
	private static func formatNumberToString(_ operand: NSDecimalNumber) -> String {
		let numberFormatter = NumberFormatter()
		// 십진법 스타일
		numberFormatter.numberStyle = .decimal
		
		// 소수 구분 기호 뒤의 최대 자릿수입니다.
		numberFormatter.maximumFractionDigits = 8
		
		// 소수 구분 기호 앞의 최대 자릿수
		numberFormatter.maximumIntegerDigits = 20
		
		// 숫자 포맷터의 최대 유효 자릿수
		numberFormatter.maximumSignificantDigits = 20
		
		// 포맷터가 숫자의 서식을 지정할 때 최소 및 최대 유효 자릿수를 사용하는지 여부를 나타내는 부울 값
		numberFormatter.usesSignificantDigits = true
		
		// 수신자가 사용하는 반올림 모드
		numberFormatter.roundingMode = .halfUp
		
		guard let numberFormatted = numberFormatter.string(for: operand) else {
			return CalculateNamespace.empty
		}
		return numberFormatted
	}
	
	static func removeComma(_ operand: String) -> String {
		// 문자열의 지정된 범위에서 대상 문자열의 모든 항목이 다른 지정된 문자열로 대체되는 새 문자열을 반환합니다.
		// 12,345,678 -> 123456789
		return operand.replacingOccurrences(of: ",", with: "")
	}
}
