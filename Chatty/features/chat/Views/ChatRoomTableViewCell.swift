//
//  ChatRoomTableViewCell.swift
//  Chatty
//
//  Created by GONOSEN on 14/08/2022.
//

import UIKit
import BadgeSwift

class ChatRoomTableViewCell: UITableViewCell {
    @IBOutlet weak var unreadCountLabel: BadgeSwift!
    @IBOutlet weak var roomAvatarImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var lastMessageContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
}
