//
//  ViewController.swift
//  Drink
//
//  Created by 유준상 on 2022/03/23.
//

import UIKit
import UserNotifications

class AlertListViewController: UITableViewController {
    var alertList: [Alert] = []
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alertList = alerts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }

    @IBAction func didTapAddAlertButton(_ sender: UIBarButtonItem) {
        guard let addAlertVC = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else { return }
        
        addAlertVC.pickedDate = { [weak self] date in
            guard let self = self else { return }
            
            var alerts = self.alerts()
            let newAlert = Alert(date: date, isOn: true)
             
            alerts.append(newAlert)
            alerts.sort { $0.date < $1.date }
            
            self.alertList = alerts
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alertList), forKey: "alerts")
            
            self.userNotificationCenter.addNotificationRequest(by: newAlert)
            
            self.tableView.reloadData()
        }
        
        self.present(addAlertVC, animated: true)
    }
    
    func alerts() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return [] }
        return alerts
    }
}

extension AlertListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "물마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListCell", for: indexPath) as? AlertListCell else { return UITableViewCell() }
        
        let alert = alertList[indexPath.row]
        cell.alertSwitch.isOn = alert.isOn
        cell.timeLabel.text = alert.time
        cell.meridiemLabel.text = alert.meridiem
        
        cell.alertSwitch.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.alertList.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alertList), forKey: "alerts")
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [self.alertList[indexPath.row].id])
            tableView.reloadData()
        default:
            break
        }
    }
}
