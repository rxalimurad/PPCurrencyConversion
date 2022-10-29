//
//  ViewController.swift
//  PPCurrencyConversion
//
//  Created by murad on 28/10/2022.
//

import UIKit
import Combine

class CurrencyConversionScene: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var selector: SelectorInputWidget!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var amountInput: TextInputWidget!
    private var spinner = UIActivityIndicatorView(style: .large)
    private var errorLabel = UILabel()
    
    
    // MARK: - Properties
    private var viewModel =  CurrencyConversionViewModel(service: CurrencyConversionService())
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrencyList()
        observeRateList()
        setDelegates()
        addProgressIndicator()
        addErrorView()
        observeForErrors()
        
    }
    
    // MARK: - Methods
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        amountInput.delegate = self
        selector.delegate = self
    }
    
    private func fetchCurrencyList() {
        viewModel.$currencyListModel
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.selector.data = self.viewModel.currencyListModel.currencyList
                self.spinner.isHidden = !self.viewModel.currencyListModel.currencyList.isEmpty
                self.selector.isUserInteractionEnabled = self.spinner.isHidden
            }.store(in: &bindings)
    }
    private func addProgressIndicator() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: selector.centerXAnchor).isActive = true
                spinner.centerYAnchor.constraint(equalTo: selector.centerYAnchor).isActive = true
        spinner.tintColor = .blue
        selector.isUserInteractionEnabled = false
    }
    private func addErrorView() {
        let errorMsg = NSLocalizedString("Something went wrong\nPlease try again!!!", comment: "")
        errorLabel.text = errorMsg
        errorLabel.font = .systemFont(ofSize: 20)
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(errorLabel)
        errorLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        errorLabel.isHidden = true
    }
    
    
    
    private func observeRateList() {
        viewModel.$rateList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }.store(in: &bindings)
    }
 
    private func observeForErrors() {
        viewModel.$showError
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.errorLabel.isHidden = !self.viewModel.showError || self.spinner.isHidden
            }.store(in: &bindings)
    }
    
}

// MARK: - UITextfield Delegate implementation
extension CurrencyConversionScene: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textView: UITextField) {
        self.collectionView.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == NumberFormatter().decimalSeparator &&
            textField.text!.contains(NumberFormatter().decimalSeparator)
        {
            return false
        }
        return true
    }
}
// MARK: - Collection View Delegate implementation
extension CurrencyConversionScene: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currencyListModel.currencyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width / 3) - 5
        return CGSize(width: size, height: size + 20)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.toAmountCell, for: indexPath)
        let currency = viewModel.currencyListModel.currencyList[indexPath.row]
        if let amountCell = cell as? ToAmountCell {
            if let inputAmount = Double(amountInput.text!),
               let selectedCurrency = selector.currentSelectedValue?.key {
                let convertedAmount = viewModel.convertAmount(amount: inputAmount, from: selectedCurrency, to: currency.key)
                amountCell.setLableText(currCode: currency.key, currName: currency.value, amount: convertedAmount)
                amountCell.toggleView(isShowing: true)
                return amountCell
            } else {
                amountCell.toggleView(isShowing: false)
                return amountCell
            }
        }
        
        return cell
    }
}

