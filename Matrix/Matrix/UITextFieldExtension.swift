//
//  UITextFieldExtension.swift
//  Matrix
//
//  Created by Prateek Kohli on 11/03/17.
//  Copyright © 2017 VGgroup. All rights reserved.
//

import UIKit

extension UITextField
{
    func addToolbar(title:String)
    {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(UITextField.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        if !title.isEmpty
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.textAlignment = .center
            label.text = title
            
            let titleButton = UIBarButtonItem.init(customView: label)
            toolBar.setItems([spaceButton, titleButton,spaceButton, doneButton], animated: false)
            
        }else
        {
            toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        }
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        self.inputAccessoryView = toolBar
    }
    
//    func addToolbar(nextActionHandler:@escaping ()->Void)
//    {
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(nextActionHandler))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        
//        if !title.isEmpty
//        {
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//            label.textAlignment = .center
//            label.text = title
//            
//            let titleButton = UIBarButtonItem.init(customView: label)
//            toolBar.setItems([spaceButton, titleButton,spaceButton, doneButton], animated: false)
//            
//        }else
//        {
//            toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
//        }
//        
//        toolBar.isUserInteractionEnabled = true
//        toolBar.sizeToFit()
//        
//        self.inputAccessoryView = toolBar
//    }

    
    func donePressed()
    {
        self.resignFirstResponder()
    }
    
    
}
