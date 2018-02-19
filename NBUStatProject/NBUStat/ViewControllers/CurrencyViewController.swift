//
//  CurrencyViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    weak var presenter: CurrencyRateTableViewController?
    var date = Date()
    {
        didSet{
            picker.date = self.date
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var yesterdayButton: UIButton!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var tomorrowLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dropdownMarker: UIImageView!
    
    lazy var picker: UIDatePicker = {
                    let picker = UIDatePicker()
                    picker.date = self.date
                    picker.datePickerMode = .date
                    picker.maximumDate = Date()
                    picker.minimumDate = Date(timeIntervalSince1970: 946727869)
                    picker.sizeToFit()
                    return picker
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
        updateDate(label: dateLabel, date: date)
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
        presenter?.setDate(date: date)
        updateDate(label: dateLabel, date: date)
    }
    
    
    @objc func cancelPicker()
    {
        closePicker()
    }
    
    @objc func handleDynamicTypeChange(notification: Notification)
    {
        presenter?.tableView.reloadData()
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
        date = date.addingTimeInterval(-1*24*60*60)
        presenter?.setDate(date: date)
        updateDate(label: dateLabel, date: date)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        date = date.addingTimeInterval(1*24*60*60)
        presenter?.setDate(date: date)
        updateDate(label: dateLabel, date: date)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let presenter = segue.destination as? CurrencyRateTableViewController
        {
            self.presenter = presenter
            self.presenter?.setDate(date: date)
            self.presenter?.openDetail = { [weak self](cc) in
                self?.detailedCurrency = cc
                if cc != ""
                {
                    
                    self?.navigationController?.performSegue(withIdentifier: "ShowCurrency", sender: nil)
                }
            }
        }
    }
 
    

    
    func updateDate(label: UILabel, date: Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        self.date = date
        label.text = dateFormatter.string(from: date)
        yesterdayLabel.text = dateFormatter.string(from: date.addingTimeInterval(-1*24*60*60))
        tomorrowLabel.text = dateFormatter.string(from: date.addingTimeInterval(1*24*60*60))
        
    }

    
}
