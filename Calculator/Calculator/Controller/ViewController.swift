//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var calculateScrollView: UIScrollView!
	@IBOutlet weak var expressionContainerStackView: UIStackView!
	
	@IBOutlet weak var expressionStackView: UIStackView!
	@IBOutlet weak var diplayOperatorLabel: UILabel!
	@IBOutlet weak var diplayNumberLabel: UILabel!
	
	@IBOutlet weak var operatorLabel: UILabel!
	@IBOutlet weak var numberLabel: UILabel!
	
	@IBOutlet weak var divideButton: UIButton!
	@IBOutlet weak var mutiplyButton: UIButton!
	@IBOutlet weak var minusButton: UIButton!
	@IBOutlet weak var addButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
    }
	
	var numberList: [String] = []
	
	@IBAction func didTapNumbers(_ sender: UIButton) {
		guard let userInputNumbers = sender.currentTitle else {
			return
		}
		
		numberList.append(userInputNumbers)
		
		numberList.forEach {
			self.numberLabel.text? += $0
		}
		
		divideButton.addTarget(self, action: #selector(didTapDivideButton), for: .touchUpInside)
		mutiplyButton.addTarget(self, action: #selector(didTapMultiplyButton), for: .touchUpInside)
		minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
		addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
		
	}
	
	@objc func didTapDivideButton(_ sender: UIButton) {
		self.numberLabel.text = "0"
	}
	@objc func didTapMultiplyButton(_ sender: UIButton) {
		self.numberLabel.text = "0"
	}
	@objc func didTapMinusButton(_ sender: UIButton) {
		self.numberLabel.text = "0"
	}
	@objc func didTapAddButton(_ sender: UIButton) {
		self.numberLabel.text = "0"
	}
	
	
	@IBAction func didTapOperators(_ sender: UIButton) {
		self.operatorLabel.text = sender.currentTitle
		
	}
	

}

