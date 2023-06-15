//
//  UILabel+Extension.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/14.
//

import UIKit

extension UILabel {
	var unwrappedText: String {
		return self.text ?? ""
	}
	
	static func generate(text: String) -> Self {
		let label = Self()
		label.text = text
		label.textColor = .white
		label.font = UIFont.preferredFont(forTextStyle: .title3)
		return label
	}
}
