//
//  ExtensionForAlert.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 09/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertMsg(title: String, message: String){
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        print("popup disappeared")
    }
    
    func showActionSheet(_ delegate: UIViewController, message: String, strtittle: String, actionTittle: [String], images: [String: UIImage], withHandler handler: [((UIAlertAction) -> Void)]?)
    {
        var actionSheetController: UIAlertController = UIAlertController()
        
        actionSheetController = UIAlertController(title: strtittle, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        
        for i in 0..<(actionTittle.count - 1)
        {
            let listAction = UIAlertAction(title: actionTittle[i], style: .default, handler: handler?[i])
            if let image = images[actionTittle[i]] {
                listAction.setValue(image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) , forKey: "image")
            }
            actionSheetController.addAction(listAction)
        }
        let listAction = UIAlertAction(title: actionTittle[actionTittle.count-1], style: .cancel, handler: handler?[actionTittle.count-1])
        if let image = images[actionTittle[actionTittle.count-1]] {
            listAction.setValue(image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) , forKey: "image")
            
        }
        actionSheetController.addAction(listAction)
        delegate.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    func showPermissionAlert(_ delegate: UIViewController, strtittle: String, message: String, actionTittle: String, completion: @escaping () -> Void)
    {
        var alertController: UIAlertController = UIAlertController()
        
        alertController = UIAlertController(title: strtittle, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: actionTittle, style: .default, handler: { (action: UIAlertAction!) in
            completion()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        delegate.present(alertController, animated: true, completion: nil)
        
    }
    
    
}
