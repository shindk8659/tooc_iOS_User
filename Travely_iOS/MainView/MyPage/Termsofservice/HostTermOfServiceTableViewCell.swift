//
//  HostTermOfServiceTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/9/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class HostTermOfServiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var termOfServiceTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        var frame = self.termOfServiceTextView.frame
        frame.size.height = self.termOfServiceTextView.contentSize.height
        self.termOfServiceTextView.frame = frame
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
