//
//  EditItemViewController.swift
//  Bucket List jss8ny
//
//  Created by Jennifer Sheng on 10/23/22.
//

import UIKit

class EditItemViewController: UIViewController {
    
    var newBucketListItems = [[BucketListItem]]()
    var section = -1
    var itemInd = -1
    
    @IBOutlet weak var editItemTitleBox: UITextView!
    @IBOutlet weak var editDueDatePicker: UIDatePicker!
    @IBOutlet weak var editCompleteDate: UITextField!
    
    @IBAction func editItemCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var editItemSaveButton: UIBarButtonItem!
    
    // preload the screen with the information of the selected bucket list item
    func preLoadData() {
        let item = newBucketListItems[section][itemInd]
        editItemTitleBox.text = item.title
        editDueDatePicker.date = item.dueDate
        if item.completed {
            let df = DateFormatter()
            df.dateStyle = .medium
            editCompleteDate.text = df.string(from: item.completedDate)
        }
        else {
            editCompleteDate.text = "Item has not yet been completed."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        preLoadData()
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    
    // passes necessary data back to the main screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editItemSaveSegue") {
            if let bucketListTableVC = segue.destination as?
                BucketListTableViewController {
                // updates bucket list item with edited information
                newBucketListItems[section][itemInd].title = editItemTitleBox.text!
                newBucketListItems[section][itemInd].dueDate = editDueDatePicker.date
                if section == 0 {
                    newBucketListItems[section].sort(by: {$0.dueDate < $1.dueDate})
                }
                bucketListTableVC.bucketListItems = newBucketListItems
            }
        }
    }

}
