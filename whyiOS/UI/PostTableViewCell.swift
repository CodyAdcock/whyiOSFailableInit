//
//  PostTableViewCell.swift
//  whyiOS
//
//  Created by Cody on 9/5/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate: class{
    func updateView()
}

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    
    var post: Post?{
        didSet{
            updateView()
        }
    }
    
    weak var delegate: PostTableViewCellDelegate?
    
    func updateView(){
        guard let post = post else {return}
        nameLabel.text = post.name
        reasonLabel.text = post.reason
        cohortLabel.text = post.cohort
        
//        delegate?.updateView()
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
