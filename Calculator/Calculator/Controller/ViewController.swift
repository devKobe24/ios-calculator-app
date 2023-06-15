//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var operatorLabel: UILabel!
	@IBOutlet weak var operandLabel: UILabel!
	@IBOutlet weak var calculateScrollView: UIScrollView!
	@IBOutlet weak var expressionContainerStackView: UIStackView!
	
	private var isReset: Bool = false
	private var lastOperand: String = CalculateNamespace.empty
	
	private var operatorValue: String {
		get {
			return operatorLabel.text ?? CalculateNamespace.empty
		}
		set {
			return operatorLabel.text = newValue
		}
	}
	
	private var operandValue: String {
		get {
			return OperandFormatter.removeComma(operandLabel.text ?? CalculateNamespace.zero)
		}
		set {
			operandLabel.text = OperandFormatter.formatInput(newValue)
		}
	}
	
	private var currentLabelValues: ExpressionValues {
		get {
			return (operandValue: operandValue,
					operatorValue: operatorValue)
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		deleteAllExpressionContainerStackView()
		setUpExpressionValues(ExpressionValueParser.getDefaultExpressionValues())
    }
	
	private func setUpExpressionValues(_ status: ExpressionValues) {
		self.operandValue = status.operandValue
		self.operatorValue = status.operatorValue
	}
	
	private func deleteAllExpressionContainerStackView() {
		// arrangedSubviews == 스택뷰에 의해 정렬된 뷰의 목록입니다.
		expressionContainerStackView.arrangedSubviews.forEach {
			$0.removeFromSuperview()
		}
	}
	
	@IBAction private func touchUpButtons(_ sender: UIButton) {
		guard let senderTitle = sender.currentTitle else { return }
		let buttonType: ButtonType = ButtonType.getType(senderTitle)
		
		switch buttonType {
		case .equal:
			touchUpEqualButton()
			return
		case .operators:
			guard operandValue != CalculateNamespace.nan else { return }
			touchUpOperatorButton()
		case .allClear:
			deleteAllExpressionContainerStackView()
		case .numbers, .doubleZero, .dot:
			touchUpNumbersButton()
		default:
			break
		}
		
		let expressionValues: ExpressionValues = ExpressionValueParser.expressionValues(button: buttonType,
																						buttonTitle: senderTitle,
																						expressionValues: currentLabelValues,
																						isReset: isReset)
		
		setUpExpressionValues(expressionValues)
		isReset = buttonType == .toggleSign ? isReset : false
	}
	
	private func touchUpEqualButton() {
		guard operatorValue != CalculateNamespace.empty else { return }
		setLastOperand()
		addNewExpressionContainerStackView(currentLabelValues)
		
		let mergeAllExpression = mergeAllExpressionList()
		var expression = ExpressionParser<Double, Operator>.parse(from: mergeAllExpression)
		
		do {
			let calculatorResult = try expression.result()
			let expressionValues: ExpressionValues = ExpressionValueParser.parseExpressionForEqual(result: calculatorResult)
			setUpExpressionValues(expressionValues)
		} catch CalculationError.divideByZero {
			setUpExpressionValues(ExpressionValueParser.getNotANumberExpressionValues())
		} catch {
			print(CalculationError.unknown.message)
			setUpExpressionValues(ExpressionValueParser.getNotANumberExpressionValues())
		}
	}
	
	private func setLastOperand() {
		if lastOperand == CalculateNamespace.zero && lastOperand != operandValue {
			if lastOperand != CalculateNamespace.empty {
				addNewExpressionContainerStackView(ExpressionValueParser.getDefaultExpressionValues())
			}
		}
		lastOperand = operandValue
	}
	
	private func touchUpOperatorButton() {
		setLastOperand()
		
		if operandValue != CalculateNamespace.zero {
			addNewExpressionContainerStackView(currentLabelValues)
		}
	}
	
	private func touchUpNumbersButton() {
		if isReset {
			addNewExpressionContainerStackView(currentLabelValues)
		}
	}
	
	private func addNewExpressionContainerStackView(_ expressionValues: ExpressionValues) {
		let newExpressionStackView = UIStackView()
		let newOperatorLabel = UILabel()
		let newOperlandLabel = UILabel()
		
		newOperatorLabel.text = expressionValues.operatorValue
		newOperlandLabel.text = OperandFormatter.formatStringOperand(expressionValues.operandValue)
		newOperlandLabel.textColor = .white
		newOperatorLabel.textColor = .white
		newExpressionStackView.addArrangedSubview(newOperatorLabel)
		newExpressionStackView.addArrangedSubview(newOperlandLabel)
		expressionContainerStackView.addArrangedSubview(newExpressionStackView)
		setUpScrollViewOffSet()
	}
	
	private func setUpScrollViewOffSet() {
		let offSet = CGPoint(x: 0,
							 y: calculateScrollView.contentSize.height)
		calculateScrollView.setContentOffset(offSet, animated: false)
		calculateScrollView.setNeedsLayout()
	}
	
	private func mergeAllExpressionList() -> String {
		var mergedExpressionList: [String] = []
		var result: String = CalculateNamespace.empty
		let expressionList = flattenExpressionList()
		
		for text in expressionList {
			guard let lastResult = mergedExpressionList.popLast(),
				  text != CalculateNamespace.empty else {
				mergedExpressionList.append(CalculateNamespace.empty)
				continue
			}
			result = lastResult + text
			mergedExpressionList.append(result)
		}
		isReset = true
		
		return result
	}
	
	private func flattenExpressionList() -> [String] {
		var result: [String] = []
		let expressionList = expressionContainerStackView.arrangedSubviews.reduce([]) { $0 + $1.subviews }
		
		for item in expressionList {
			guard let singleLabel = item as? UILabel,
				  let labelText = singleLabel.text else { continue }
			result.append(OperandFormatter.removeComma(labelText))
		}
		return result
	}


}

