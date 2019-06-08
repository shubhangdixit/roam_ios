//
//  HomeViewController.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 05/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var panView: UIView!
    
    let kMenuViewMaximumHeight : CGFloat = 650.0
    let kMenuViewMinimumHeight : CGFloat = 200.0
    
    var isMenuExpanded = false
    
    @IBOutlet weak var optionsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleString = "ROAM"
        self.navigationController?.navigationBar.topItem?.title = titleString
        setupGradientLayer()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        
        panView.isUserInteractionEnabled = true
        panView.addGestureRecognizer(panGesture)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: "MenuOptionsCell", bundle: Bundle.main), forCellReuseIdentifier: "MenuOptionsCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuView.layer.cornerRadius = 10
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize(width: 0, height: 5)
        menuView.layer.shadowRadius = 15
    }
    
    private func setupGradientLayer () {
        let gradient = CAGradientLayer()
        
        gradient.frame = topView.bounds
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.init(white: 0, alpha: 0).cgColor
        ]
        topView.backgroundColor = .clear
        topView.layer.insertSublayer(gradient, at: 0)
        previewImageView.image = UIImage(named: "defaultImage.jpeg")
        view.sendSubviewToBack(previewImageView)
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
            UIView.animate(withDuration: 30, delay: 0, options: .curveEaseOut, animations: {
                self.menuViewHeightConstraint.constant = self.menuViewHeightConstraint.constant > 300 ? 600 : 235
                 self.navigationController?.navigationBar.topItem?.title = self.menuViewHeightConstraint.constant > 300 ? "HOME" : "ROAM"
                self.menuTableView.reloadData()
            }, completion: nil)
        }
    }
    
    func mainMenuIsExpanded() -> Bool {
        return menuViewHeightConstraint.constant == 235 ? false : true
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = self.menuTableView.dequeueReusableCell(withIdentifier: "SearchBarCell")
        return headerCell?.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 71.0
    }
    
    
}
