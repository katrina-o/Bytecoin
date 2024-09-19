//
//  ViewController.swift
//  Bytecoin
//
//  Created by Катя on 25.07.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    

    var coinManager = CoinManager()
    
    let upStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 25
        return stack
    }()
    
    var bitcoinLabel:UILabel = {
        let label = UILabel()
        label.text = "ByteCoin"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 50)
        return label
        
    }()
    
    let coinView:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    var imageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bitcoinsign.circle.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        return image
    }()
    
    var resultLabel:UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .right
        
        return label
    }()
    
    
    var currencyLabel:UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    
    var currencyPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.contentMode = .scaleAspectFill

        
        return picker
    }()
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    
    func initialize() {
        view.backgroundColor = .systemMint
        view.addSubview(upStackView)
        
        upStackView.addArrangedSubview(bitcoinLabel)
        upStackView.addArrangedSubview(coinView)
        
        coinView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(resultLabel)
        stackView.addArrangedSubview(currencyLabel)
        
        view.addSubview(currencyPicker)
        
        
        upStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        coinView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(10)
            make.height.equalTo(80)
        }
        
        
        stackView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
        }


        currencyPicker.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(216)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }


}

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        
        DispatchQueue.main.async {
            self.resultLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return coinManager.currencyArray.count
      }
      
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return coinManager.currencyArray[row]
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          let selectedCurrency = coinManager.currencyArray[row]
          coinManager.getCoinPrice(for: selectedCurrency)
      }
}
