//
//  ViewController.swift
//  CreditCardList
//
//  Created by 유준상 on 2022/03/08.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore

class CardListViewController: UITableViewController {
//    var ref: DatabaseReference!
    var db = Firestore.firestore()
    var creditCardList: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        // 실시간 데이터베이스 읽기
//        ref = Database.database().reference()
//
//        ref.observe(.value) { [weak self] snapshot in
//            guard let self = self else { return }
//            guard let value = snapshot.value as? [String: [String: Any]] else { return }
//
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch let error {
//                print("ERROR JSON PARSING : \(error.localizedDescription)")
//            }
//        }
        
        // Firestore 데이터베이스 읽기
        db.collection("creditCardList").addSnapshotListener { [weak self] snapshot, error in
            guard let documents = snapshot?.documents else {
                debugPrint("ERROR Firestore fetching document \(String(describing: error))")
                return
            }
            
            self?.creditCardList = documents.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    debugPrint("ERROR JSON parsing \(error.localizedDescription)")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }
        
        let creditCard = creditCardList[indexPath.row]
        cell.rankLabel.text = "\(creditCard.rank)위"
        cell.promotionLabel.text = "\(creditCard.promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCard.name)"
        
        let imageURL = URL(string: creditCard.cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else { return }
        
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
         
        // 실시간 데이터베이스 쓰기
        //        let cardId = creditCardList[indexPath.row].id
        // Option 1
        //        ref.child("Item\(cardId)/isSelected").setValue(true)
        
        // Option 2
        //        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value) { [weak self] snapshot in
        //            guard let self = self,
        //                  let value = snapshot.value as? [String: [String: Any]],
        //                  let key = value.keys.first else { return }
        //
        //            self.ref.child("\(key)/isSelected").setValue(true)
        //    }
        
        // Firestore 데이터베이스 쓰기
        // Option 1
        let cardId = creditCardList[indexPath.row].id
//        db.collection("creditCardList").document("card\(cardId)").updateData(["isSelected": true])
        
        // Option2
        db.collection("creditCardList").whereField("id", isEqualTo: cardId).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents.first else {
                debugPrint("ERROR Firestore fetching document")
                return
            }
            document.reference.updateData(["isSelected": true])
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 실시간 데이터베이스 삭제
//            let cardId = creditCardList[indexPath.row].id
//            // Option 1
//            ref.child("Item\(cardId)").removeValue()
            
            // Option2
            //            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value) { [weak self] snapshot in
            //                guard let self = self,
            //                      let value = snapshot.value as? [String: [String: Any]],
            //                      let key = value.keys.first else { return }
            //                self.ref.child(key).removeValue()
            //            }
            
            // Firestore 데이터베이스 삭제
            let cardId = creditCardList[indexPath.row].id
            // Option 1
//            db.collection("creditCardList").document("card\(cardId)").delete()
            
            // Option 2
            db.collection("creditCardList").whereField("id", isEqualTo: cardId).getDocuments { snapshot, _ in
                guard let document = snapshot?.documents.first else {
                    debugPrint("ERROR Firestore fetching document")
                    return
                }
                document.reference.delete()
            }
        }
    }
}
