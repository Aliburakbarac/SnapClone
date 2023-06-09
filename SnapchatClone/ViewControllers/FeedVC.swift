//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Ali Burak Baraç on 9.05.2023.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func getUserInfo() {
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
                    if error != nil {
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    } else {
                        if snapshot?.isEmpty == false && snapshot != nil {
                            for document in snapshot!.documents {
                                if let username = document.get("username") as? String {
                                    UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                                    UserSingleton.sharedUserInfo.username = username
                            
                        }
                    }
                }
            }
        }
    }
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
