//
//  ToAmountCell.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import UIKit

class ToAmountCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private var currCode: UILabel!
    @IBOutlet private var currName: UILabel!
    @IBOutlet private var amount: UILabel!
    
    // MARK: - Methods
    func setLableText(currCode: String, currName: String, amount: Double?) {
        self.currCode.text = "(\(currCode))"
        self.currName.text = currName
        if let amount = amount {
            self.amount.text = "\(amount)"
        } else {
            self.amount.text = ""
            debugPrint("Rate not found for \(currCode) \(currName)")
        }
    }
}
