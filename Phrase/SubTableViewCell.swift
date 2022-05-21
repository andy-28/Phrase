//
//  SubTableViewCell.swift
//  Phrase
//
//  Created by 江啟綸 on 2022/5/13.
//

import UIKit

class SubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textKK: UILabel!
    @IBOutlet weak var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customView.layer.cornerRadius = 15
        customView.layer.backgroundColor = UIColor(named: "DGray")?.cgColor
        customView.layer.borderColor = UIColor(named: "DborderGray")?.cgColor
        customView.layer.borderWidth = 3
        // 客製化cell
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
