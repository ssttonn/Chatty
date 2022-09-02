//
//  MessageChatCellTableViewCell.swift
//  Chatty
//
//  Created by sstonn on 28/08/2022.
//

import UIKit

class MessageChatCell: UITableViewCell{
    let bubbleView: ChatBubbleView = {
        let v = ChatBubbleView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var leadingOrTrailingConstraint = NSLayoutConstraint()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() -> Void {
        
        // add the bubble view
        contentView.addSubview(bubbleView)
        
        // constrain top / bottom with 12-pts padding
        // constrain width to lessThanOrEqualTo 2/3rds (66%) of the width of the cell
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.66),
        ])
        
    }
    
    func setMessage(_ message: MessageModel) -> Void {

            // set the label text
            bubbleView.chatLabel.text = message.messageContent

            // tell the bubble view whetheÏr it's an incoming or outgoing message
            bubbleView.incoming = message.isIncomingMessage

            // left- or right-align the bubble view, based on incoming or outgoing
            leadingOrTrailingConstraint.isActive = false
            if bubbleView.incoming {
                leadingOrTrailingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0)
            } else {
                leadingOrTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
            }
            leadingOrTrailingConstraint.isActive = true
        }
}
