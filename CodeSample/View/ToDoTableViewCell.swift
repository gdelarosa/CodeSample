//
//  ToDoTableViewCell.swift
//  CodeSample
//
//  Created by Gina De La Rosa on 6/2/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  Will display the title and completion for the todo list

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
