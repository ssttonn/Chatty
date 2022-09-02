//
//  ChatRoomDetailViewController.swift
//  Chatty
//
//  Created by sstonn on 27/08/2022.
//

import UIKit
import FirebaseAuth
import AVFoundation

class ChatRoomDetailViewController: UIViewController {
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var chatTextField: MainTextField!
    
    var roomId: String = ""
    
    var listenToMessageListUC: ListenToMessageListUC = ListenToMessageListUC()
    var sendMessageUC: SendMessageUC = SendMessageUC()
    
    var messages: [MessageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initAllPrefs()
    }
}

//MARK: Initial code for all preferences
extension ChatRoomDetailViewController{
    func initAllPrefs(){
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.register(MessageChatCell.self, forCellReuseIdentifier: "MessageChatCell")
        listenToMessageListUC.delegate = self
        listenToMessageListUC.call(params: ListenToMessageListParams(roomId: roomId))
        sendMessageUC.delegate = self
    }
}

//MARK: Handle IBActions methods
extension ChatRoomDetailViewController{
    @IBAction func onSendBtnPressed(_ sender: UIButton) {
        chatTextField.resignFirstResponder()
        let messageEntity = MessageEntity( content: chatTextField.text, roomId: roomId, senderId: FirebaseAuth.Auth.auth().currentUser?.uid)
        sendMessageUC.call(params: SendMessageUCParams(entity: messageEntity))
    }
}

//MARK: Play message audios
extension ChatRoomDetailViewController{
    func playSound(withSoundName name: String) {
        var player: AVAudioPlayer?
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

//MARK: TableView datasource
extension ChatRoomDetailViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "MessageChatCell", for: indexPath) as! MessageChatCell
        cell.setMessage(messages[indexPath.row])
        return cell
    }
}

//MARK: TableViewCell delegate methods
extension ChatRoomDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
    
    private func scrollToBottom(){
        let indexPath = IndexPath(row: self.messages.count-1, section: 0)
        self.messagesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
}

//MARK: Handle to message changed methods
extension ChatRoomDetailViewController: ListenToMessageListUCDelegate{
    func onNewMessageCame(_ host: ListenToMessageListUC, addedMessage: MessageModel) {
        messages.append(addedMessage)
        self.messagesTableView.reloadData()
        playSound(withSoundName: "sentmessage")
        scrollToBottom()
    }
    
    func onMessageUpdated(_ host: ListenToMessageListUC, updatedMessage: MessageModel) {
        if messages.contains(where: {$0 == updatedMessage}), let updatedIndex = messages.firstIndex(of: updatedMessage){
            self.messages[updatedIndex] = updatedMessage
        }
        self.messagesTableView.reloadData()
    }
    
    func onMessageDeleted(_ host: ListenToMessageListUC, deletedMessage: MessageModel) {
        if messages.contains(where: {$0 == deletedMessage}){
            self.messages.removeAll(where: {$0 == deletedMessage})
        }
        self.messagesTableView.reloadData()
    }
    
    func onFetchingMessages(_ host: ListenToMessageListUC) {
        
    }
    
    func didFailWithError(_ host: ListenToMessageListUC, error: Error) {
        
    }
}

//MARK: Handle to message send methods
extension ChatRoomDetailViewController: SendMessageUCDelegate{
    func didSendMessageSuccessfully(_ host: SendMessageUC) {
        chatTextField.text = ""
    }
    
    func onSending(_ host: SendMessageUC) {
        
    }
    
    func didFailWithError(_ host: SendMessageUC, error: Error) {
        chatTextField.text = ""
    }
    
    
}
