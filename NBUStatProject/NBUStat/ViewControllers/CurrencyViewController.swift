//
//  CurrencyViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    var presenter: DateDependedPresenterProtocol = NBUCurrencyRatesManager(date: Date())

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var yesterdayButton: UIButton!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var tomorrowLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dropdownMarker: UIImageView!
    
    lazy var picker: UIDatePicker = {
        return self.presenter.picker
    }()
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor =  UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Готово", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let todayButton = UIBarButtonItem(title: "Сьогодні", style: UIBarButtonItemStyle.plain, target: self, action: #selector(todayPicker))
        let cancelButton = UIBarButtonItem(title: "Відміна", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        toolBar.setItems([cancelButton, spaceButton, todayButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()
    
    private(set) var detailedCurrency: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDate(label: dateLabel)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleDynamicTypeChange(notification:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        dateTextField.inputView = picker
        dateTextField.inputAccessoryView = toolBar
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }

    //MARK: - date picker handling
    @objc func donePicker()
    {
        closePicker(with: picker.date)
    }
    
    @objc func todayPicker()
    {
        closePicker(with: Date())
    }
    
    private func closePicker(with date: Date? = nil)
    {
        dropdownMarker.transform = CGAffineTransform(rotationAngle: 0)
        dateTextField.resignFirstResponder()
        guard let date = date else { return }
        presenter.date = date
        updateDate(label: dateLabel)
    }
    
    
    @objc func cancelPicker()
    {
        closePicker()
    }
    
    @objc func handleDynamicTypeChange(notification: Notification)
    {
        presenter.updateView()
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        yesterdayLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        tomorrowLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func changeDateButtonPressed(_ sender: Any) {
        dropdownMarker.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        dateTextField.becomeFirstResponder()
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        presenter.movePreviousDate()
        updateDate(label: dateLabel)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        presenter.moveNextDate()
        updateDate(label: dateLabel)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? NBURatesTableViewController
        {
            viewController.presenter = presenter
            viewController.presenter.delegate = viewController
            viewController.openDetail = { [weak self](cc) in
                self?.detailedCurrency = cc
                if cc != ""
                {
                    self?.performSegue(withIdentifier: "ShowCurrency", sender: nil)
                }
            }
        }
        else if let viewController = segue.destination as? CurrencyDetailContainerViewController
        {
            viewController.currency = detailedCurrency
        }
    }
 
    

    
    func updateDate(label: UILabel)
    {
        label.text = presenter.currentDate
        yesterdayLabel.text = presenter.prevDate
        tomorrowLabel.text = presenter.nextDate
    }

    
}
