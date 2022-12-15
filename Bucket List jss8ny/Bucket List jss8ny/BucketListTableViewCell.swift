//
//  BucketListTableViewCell.swift
//  Bucket List jss8ny
//

import UIKit

class BucketListTableViewCell: UITableViewCell {
    
    // Reference:
    // https://stevenpcurtis.medium.com/handle-button-presses-in-customuitableviewcells-without-tags-48941542447a
    var closure: (()->())?
    @IBAction func checkBoxClicked(_ sender: UIButton) {
        closure?()
    }
    
    @IBOutlet weak var tableItemTitleBox: UILabel!
    @IBOutlet weak var tableItemDueDate: UILabel!
    @IBOutlet weak var tableItemCompletedDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
