//
//  AddItemViewController.swift
//  Bucket List jss8ny
//
//  Created by Jennifer Sheng on 10/23/22.
//

import UIKit

class AddItemViewController: UIViewController {
    
    var newBucketListItems = [[BucketListItem]]()
    
    @IBOutlet weak var addItemTitleBox: UITextView!
    @IBOutlet weak var addDueDatePicker: UIDatePicker!
    
    // Reference:
    // https://stackoverflow.com/questions/28760541/programmatically-go-back-to-previous-viewcontroller-in-swift
    @IBAction func addItemCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var addItemSaveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    
    // passes back necessary information to main screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "addItemSaveSegue") {
            if let bucketListTableVC = segue.destination as?
                BucketListTableViewController {
                // adds the new bucket list item into the running list 
                newBucketListItems[0].append(BucketListItem(title: addItemTitleBox.text!, dueDate: addDueDatePicker.date, completed: false, completedDate: Date(timeIntervalSince1970: TimeInterval(0))))
                
                // Reference:
                // https://stackoverflow.com/questions/24130026/how-to-sort-an-array-of-custom-objects-by-property-value-in-swift
                newBucketListItems[0].sort(by: {$0.dueDate < $1.dueDate})
                bucketListTableVC.bucketListItems = newBucketListItems
            }
        }
    }

}
