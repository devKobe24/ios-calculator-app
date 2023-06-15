//
//  ExpressionValueParser.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/15.
//

enum ExpressionValueParser {
	static func getDefaultExpressionValues() -> ExpressionValues {
		return (operandValue: CalculateNamespace.zero,
				operatorValue: CalculateNamespace.empty)
	}
	
	static func getNotANumberExpressionValues() -> ExpressionValues {
		return (operandValue: CalculateNamespace.nan,
				operatorValue: CalculateNamespace.empty)
	}
	
	static func expressionValues(button: ButtonType,
								 buttonTitle: String,
								 expressionValues: ExpressionValues,
								 isReset: Bool) -> ExpressionValues {
		switch button {
		case .allClear:
			return getDefaultExpressionValues()
		case .cleaeEntry:
			return(operandValue: CalculateNamespace.zero,
				   operatorValue: expressionValues.operatorValue)
		case .toggleSign:
			return parseExpressionToggleSign(expressionValues: expressionValues)
		case .dot:
			return parseExpressionForDot(expressionValue: expressionValues, isReset: isReset)
		case .doubleZero:
			return parseExpressionForDoubleZero(expressionValue: expressionValues, isReset: isReset)
		case .numbers:
			return parseLabelForNumbers(for: buttonTitle,
								 expressionValues: expressionValues,
								 isReset: isReset)
		default:
			return expressionValues
		}
	}
	
	static func parseExpressionForEqual(result calculatorResult: Double) -> ExpressionValues {
		var newOperand = String(calculatorResult)
		newOperand = OperandFormatter.formatStringOperand(newOperand)
		
		return (operandValue: newOperand,
				operatorValue: CalculateNamespace.empty)
	}
	
	private static func parseExpressionForDot(expressionValue: ExpressionValues, isReset: Bool) -> ExpressionValues {
		guard !isReset else {
			return (operandValue: CalculateNamespace.zero + CalculateNamespace.dot,
					operatorValue: expressionValue.operatorValue)
		}
		
		guard !expressionValue.operandValue.contains(CalculateNamespace.dot) else {
			return expressionValue
		}
		return (operandValue: expressionValue.operandValue + CalculateNamespace.dot,
				operatorValue: expressionValue.operatorValue)
	}
	
	private static func parseExpressionForDoubleZero(expressionValue: ExpressionValues, isReset: Bool) -> ExpressionValues {
		guard expressionValue.operandValue != CalculateNamespace.zero, !isReset else {
			return (operandValue: CalculateNamespace.zero,
					operatorValue: expressionValue.operatorValue)
		}
		return (operandValue: expressionValue.operandValue + CalculateNamespace.doubleZero,
				operatorValue: expressionValue.operandValue)
	}
	
	private static func parseLabelForNumbers(for menu: String,
											 expressionValues: ExpressionValues,
											 isReset: Bool) -> ExpressionValues {
		guard expressionValues.operandValue != CalculateNamespace.zero, !isReset else {
			return (operandValue: menu,
					operatorValue: expressionValues.operatorValue)
		}
		return (operandValue: expressionValues.operandValue + menu,
				operatorValue: expressionValues.operatorValue)
	}
	
	private static func parseExpressionToggleSign(expressionValues: ExpressionValues) -> ExpressionValues {
		guard expressionValues.operandValue != CalculateNamespace.zero,
			  let firstDigit = expressionValues.operandValue.first else {
			return (operandValue: expressionValues.operandValue,
					operatorValue: expressionValues.operatorValue)
		}
		var newOperand = expressionValues.operandValue
		
		if String(firstDigit) == CalculateNamespace.negative {
			newOperand = String(newOperand.dropFirst(1))
		} else {
			newOperand = CalculateNamespace.negative + newOperand
		}
		
		return (operandValue: newOperand,
				operatorValue: expressionValues.operatorValue)
	}
}
