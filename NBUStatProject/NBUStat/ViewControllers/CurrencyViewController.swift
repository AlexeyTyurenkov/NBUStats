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
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var yesterdayButton: UIButton!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var tomorrowLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    
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
        toolBar.tintColor =  UIColor(colorLiteralRed: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Відміна", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
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
    }

    
    func donePicker()
    {
        dateTextField.resignFirstResponder()
        date = picker.date
        presenter?.setDate(date: picker.date)
        updateDate(label: dateLabel, date: picker.date)
    }
    
    
    func cancelPicker()
    {
        dateTextField.resignFirstResponder()
    }
    
    func handleDynamicTypeChange(notification: Notification)
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
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeDateButtonPressed(_ sender: Any) {
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
    
    @IBAction func todayButtonPressed(_ sender: Any) {
        presenter?.setDate(date: Date())
        updateDate(label: dateLabel, date: Date())
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
        
        label.text = dateFormatter.string(from: date)
        yesterdayLabel.text = dateFormatter.string(from: date.addingTimeInterval(-1*24*60*60))
        tomorrowLabel.text = dateFormatter.string(from: date.addingTimeInterval(1*24*60*60))
        
    }

    
}
