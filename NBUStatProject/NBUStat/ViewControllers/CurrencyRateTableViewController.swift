//
//  CurrencyRateTableViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class CurrencyRateTableViewController: UITableViewController {

    
    
    @IBOutlet var manager: CurrencyRateManager!
    
    var searchViewController: UISearchController?
    private var lastDate: Date = Date()
    var openDetail: ((String)->())?
    private var isProfessional: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        manager.updateCallBack = {  [weak self] isProfessional in
            DispatchQueue.main.async {
                self?.isProfessional = isProfessional
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
        manager.errorMessage = {
            [weak self] error in
            let alert = UIAlertController(title: "Помилка завантаження", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in }))
            DispatchQueue.main.async {
                self?.present(alert, animated: true, completion: nil)
            }
        }
        manager.loadList(date: lastDate)
        self.searchViewController = UISearchController(searchResultsController: nil)
        definesPresentationContext = true
        self.searchViewController?.hidesNavigationBarDuringPresentation = false

        self.searchViewController?.dimsBackgroundDuringPresentation = false
        self.searchViewController?.searchResultsUpdater = manager
        self.searchViewController?.searchBar.delegate = manager
        self.searchViewController?.searchBar.placeholder = "Шукати за кодом або назвою"
        self.searchViewController?.searchBar.sizeToFit()
        self.searchViewController?.searchBar.tintColor = UIColor.white
        tableView.tableHeaderView = searchViewController!.searchBar

        manager.cancelSearch = { [weak self] in
            DispatchQueue.main.async {
                self?.searchViewController?.isActive = false
                self?.searchViewController?.searchBar.text = ""
                self?.searchViewController?.searchBar.resignFirstResponder()
                self?.searchViewController?.dismiss(animated: true, completion: {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
    
                })
                
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    func handleRefresh(_ refreshControl: UIRefreshControl) {
        manager.loadList(date: lastDate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func setDate(date: Date)
    {
        if NSCalendar.current.compare(date, to: lastDate, toGranularity: .day) != .orderedSame
        {
            lastDate = date
            manager.loadList(date: date)
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let isFavorite = manager.isFavorite(atSection: indexPath.section, andIndex: indexPath.row)
        let more = UITableViewRowAction(style: .normal, title: isFavorite ? "З обраних" : "В обрані") {
            action, index in
            self.manager.toggleMark(section: index.section, index: index.row)
            self.tableView.reloadData()
        }
        more.backgroundColor = isFavorite ? UIColor(colorLiteralRed: 213.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0) : UIColor(colorLiteralRed: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0)
        return [more]
         
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cc = self.manager.currencyCode(inSection: indexPath.section, andIndex: indexPath.row)
        openDetail?(cc)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView  else { return }
        header.textLabel?.textColor = UIColor(colorLiteralRed: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
