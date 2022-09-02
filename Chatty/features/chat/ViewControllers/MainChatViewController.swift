//
//  MainChatViewController.swift
//  Chatty
//
//  Created by GONOSEN on 14/08/2022.
//

import UIKit
import FirebaseAuth

class MainChatViewController: UITableViewController {
    @IBOutlet weak var chatRoomsView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var listenToRoomListUC = ListenToRoomListUC()
    var chatRooms: [ChatRoomModel] = [
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenToRoomListUC.delegate = self
        listenToRoomListUC.call(params: ListenToRoomListParams(userId: FirebaseAuth.Auth.auth().currentUser?.uid))
        registerTableViewCells()
        title = "Chatty"
        navigationItem.setLeftBarButton(nil, animated: true)
        chatRoomsView.delegate = self
        chatRoomsView.dataSource = self
    }
    
    private func registerTableViewCells(){
        let chatRoomCell = UINib(nibName: "ChatRoomTableViewCell", bundle: nil)
        chatRoomsView.register(chatRoomCell, forCellReuseIdentifier: "chatRoomCell")
    }
}

extension MainChatViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chatRoomCell",for: indexPath) as? ChatRoomTableViewCell {
            cell.roomNameLabel.text = chatRooms[indexPath.row].roomName
            cell.lastMessageContentLabel.text = chatRooms[indexPath.row].lastMessage.messageContent
            if chatRooms[indexPath.row].totalUnreadMessages <= 99{
                cell.unreadCountLabel.text = String(chatRooms[indexPath.row].totalUnreadMessages)
                cell.unreadCountLabel.isHidden = chatRooms[indexPath.row].totalUnreadMessages == 0
            } else{
                cell.unreadCountLabel.text = "99+"
            }
           
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatRooms.count
    }
}

extension MainChatViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        performSegue(withIdentifier: "toChatRoomDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if let selectedRow = tableView.indexPathForSelectedRow?.row{
            let destinationVC = segue.destination as! ChatRoomDetailViewController
            destinationVC.roomId = chatRooms[selectedRow].id
        }
    }
}

//MARK: Handle rooms change from usecase
extension MainChatViewController: ListenToRoomListUCDelegate{
    func onProgressing(_ host: ListenToRoomListUC) {
        
    }
    
    func didFailWithError(_ host: ListenToRoomListUC, error: Error) {
        
    }
    
    func onRoomChatAdded(_ host: ListenToRoomListUC, addedRoom: ChatRoomModel) {
        chatRooms.append(addedRoom)
        self.chatRoomsView.reloadData()
    }
    
    func onRoomChatUpdated(_ host: ListenToRoomListUC, updatedRoom: ChatRoomModel) {
        if chatRooms.contains(where: {$0 == updatedRoom}), let updatedIndex = chatRooms.firstIndex(where: { $0 == updatedRoom}) {
            chatRooms[updatedIndex] = updatedRoom
        }
        self.chatRoomsView.reloadData()
    }
    
    func onRoomChatDeleted(_ host: ListenToRoomListUC, deletedRoom: ChatRoomModel) {
        if chatRooms.contains(where: {$0 == deletedRoom}) {
            self.chatRooms.removeAll(where: {$0 == deletedRoom})
        }
        self.chatRoomsView.reloadData()
    }
    
}
