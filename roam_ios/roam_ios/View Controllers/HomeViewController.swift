//
//  HomeViewController.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 05/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import UIKit

class HomeViewController: RoamBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var panView: UIView!
    @IBOutlet weak var introLabel: UILabel!
    
    let kMenuViewMaximumHeight : CGFloat = 650.0
    let kMenuViewMinimumHeight : CGFloat = 200.0
    
    var isMenuExpanded = false
    
    @IBOutlet weak var optionsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer(topView: topView, previewImageView: previewImageView)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        
        panView.isUserInteractionEnabled = true
        panView.addGestureRecognizer(panGesture)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: "MenuOptionsCell", bundle: Bundle.main), forCellReuseIdentifier: "MenuOptionsCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setScreenName(titleString: " ")
        if mainMenuIsExpanded() { expandMenuView() }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuView.layer.cornerRadius = 10
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize(width: 0, height: 5)
        menuView.layer.shadowRadius = 15
    }
    
    
    @objc func panAction(_ sender:UIPanGestureRecognizer) {
        let point = sender.location(in: self.view)
        if sender.state == .began || sender.state == .changed {
            let pannedHeight = view.frame.height - point.y
            if pannedHeight < kMenuViewMaximumHeight && pannedHeight > kMenuViewMinimumHeight {
                menuViewHeightConstraint.constant = view.frame.height - point.y
                self.view.layoutIfNeeded()
            }
        }
        if sender.state == .ended {
            view.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 7, animations: {
                
                self.view.layoutIfNeeded()
            }) { finished in
                self.menuViewHeightConstraint.constant = self.menuViewHeightConstraint.constant > 300 ? 235 : 600
                self.navigationController?.navigationBar.topItem?.title = self.menuViewHeightConstraint.constant > 300 ? "HOME" : " "
                self.introLabel.alpha = 0
                self.menuTableView.reloadData()
                UIView.animate(withDuration: 0.25, animations: {
                    
                    self.view.layoutIfNeeded()
                }) { finished in
                }
            }
            UIView.animate(withDuration: 0.25) {
                self.introLabel.alpha = 0
            }
        }
    }
    
    func expandMenuView () {
        
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 7, animations: {
            
            self.view.layoutIfNeeded()
        }) { finished in
            self.menuViewHeightConstraint.constant = self.menuViewHeightConstraint.constant == 600 ? 235 : 600
            self.navigationController?.navigationBar.topItem?.title = self.menuViewHeightConstraint.constant == 600 ? "HOME" : " "
            self.menuTableView.reloadData()
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
            }) { finished in
                
            }
        }
        UIView.animate(withDuration: 0.25) {
            self.introLabel.alpha = 0
        }
    }
    
    func mainMenuIsExpanded() -> Bool {
        return menuViewHeightConstraint.constant == 235 ? false : true
    }
    
    func signOut() {
        let alertMsg = AlertMesseges.logoutALert
        showPermissionAlert(self, strtittle: alertMsg.rawValue, message: alertMsg.getMessage(), actionTittle: "Continue"){
            NetworkManager.shared.signOut(success: {[weak self] (data) in
                if let success = data as? Bool {
                    if !success {
                        self?.showAlertMsg(title: "", message: "Error Logging you out.")
                    } else {
                        self?.expandMenuView()
                    }
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenuIsExpanded() ? HomeOptionType.allCases.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mainMenuIsExpanded() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionsCell") as! MenuOptionsCell
            cell.menuTitleLabel.text = HomeOptionType.allCases[indexPath.row].getTitle()
            cell.descriptionLabelk.text = HomeOptionType.allCases[indexPath.row].getDetailMessage()
            if let image = HomeOptionType.allCases[indexPath.row].imageForOption() {
                cell.optionsImage.image = image
            }
            return cell
        } else {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "exploreCell")!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if mainMenuIsExpanded() {
            let controllerName = HomeOptionType.allCases[indexPath.row].getControllerName()
            if controllerName == "" {
                signOut()
                return
            }
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: controllerName){
                
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            expandMenuView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = self.menuTableView.dequeueReusableCell(withIdentifier: "SearchBarCell")
        return headerCell?.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 71.0
    }
    
    
}
