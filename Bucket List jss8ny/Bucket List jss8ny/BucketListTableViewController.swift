//
//  ViewController.swift
//  Bucket List jss8ny
//

// Resources:
// https://bruno.ph/blog/articles/swift-tutorial-mytodo/
// https://www.raywenderlich.com/2153-how-to-make-a-gesture-driven-to-do-list-app-like-clear-in-swift-part-1-2
// https://www.kodeco.com/5055364-ios-storyboards-getting-started

import UIKit

class BucketListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    var bucketListItems = BucketListItem.getPrepopData()
    
    // Reference:
    // https://letcreateanapp.com/2021/04/15/how-to-create-uitableview-with-sections-in-swift-5/
    // sets number of sections in table to be two
    func numberOfSections(in tableView: UITableView) -> Int {
           return bucketListItems.count
    }
    
    // sets number of rows in each section to be the number of items in the coressponding completion category
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketListItems[section].count
    }
    
    // create the header title for each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Completed"
        }
        else {
            return "Completed"
        }
    }
    
    // displays relevant data of each bucket list item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set cell view based on its completion status
        var cell = tableView.dequeueReusableCell(withIdentifier: "uncompletedCell", for: indexPath) as! BucketListTableViewCell
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath) as! BucketListTableViewCell
        }
        
        let item = bucketListItems[indexPath.section][indexPath.row]
        
        if indexPath.row < bucketListItems[indexPath.section].count {
            // Reference:
            // https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
            let df = DateFormatter()
            df.dateStyle = .medium
            
            cell.tableItemTitleBox?.text = item.title
            cell.tableItemDueDate?.text = "Due Date: " + df.string(from: item.dueDate)
            if item.dueDate < Date.now {
                // Reference:
                // https://stackoverflow.com/questions/25837228/how-to-set-textcolor-of-uilabel-in-swift
                cell.tableItemDueDate?.textColor = UIColor.systemRed
            }
            cell.tableItemCompletedDate?.text = "Completed Date: " + df.string(from: item.completedDate)
            
            // Reference:
            // https://developer.apple.com/documentation/uikit/uitableview/1614940-movesection
            // when clicking on the checkbox, cell will update accordingly
            cell.closure = { [self] in
                item.completed = !item.completed
                if indexPath.section == 0 {
                    item.completedDate = Date.now
                    let rowInd = bucketListItems[0].firstIndex(of: item)!
                    
                    bucketListItems[1].insert(item, at: 0)
                    bucketListItems[0].remove(at: rowInd)
                    tableView.moveRow(at: IndexPath(row: rowInd, section: 0), to: IndexPath(row: 0, section: 1))
//                    tableView.deleteRows(at: [IndexPath(row: rowInd, section: 0)], with: .automatic)
//                    tableView.insertRows(at: [IndexPath(row:0, section: 1)], with: .automatic)
                    tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .middle)
                }
                else {
                    bucketListItems[0].append(item)
                    bucketListItems[0].sort(by: {$0.dueDate < $1.dueDate})
                    let uncompRowInd = bucketListItems[0].firstIndex(of: item)!
                    let compRowInd = bucketListItems[1].firstIndex(of: item)!
                    bucketListItems[1].remove(at: compRowInd)
                    
                    tableView.moveRow(at: IndexPath(row: compRowInd, section: 1), to: IndexPath(row: uncompRowInd, section: 0))
//                    tableView.deleteRows(at: [IndexPath(row: compRowInd, section: 1)], with: .automatic)
//                    tableView.insertRows(at: [IndexPath(row: uncompRowInd, section: 0)], with: .automatic)
                    tableView.reloadRows(at: [IndexPath(row: uncompRowInd, section: 0)], with: .middle)
                }
            }
        }
        
        return cell
    }
    
    // unhighlights the selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // delete specified row (bucket list item)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < bucketListItems[indexPath.section].count {
            bucketListItems[indexPath.section].remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // passes the necessary items to other screens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "addItemSegue") {
            if let addItemVC = segue.destination as?
                AddItemViewController {
                addItemVC.newBucketListItems = bucketListItems
            }
        }
        
        // Reference:
        // https://www.codingexplorer.com/segue-uitableviewcell-taps-swift/
        if (segue.identifier == "editItemSegue") {
            if let editItemVC = segue.destination as?
                EditItemViewController {
                editItemVC.newBucketListItems = bucketListItems
                editItemVC.section = tableView.indexPathForSelectedRow!.section
                editItemVC.itemInd = tableView.indexPathForSelectedRow!.row
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BucketListTableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

