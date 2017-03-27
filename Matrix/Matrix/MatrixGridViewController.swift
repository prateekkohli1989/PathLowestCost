//
//  MatrixGridViewController.swift
//  Matrix
//
//  Created by Prateek Kohli on 12/03/17.
//  Copyright © 2017 VGgroup. All rights reserved.
//

import UIKit

let MAX_CHAR_LIMIT = 3


public class MatrixGridViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate,UICollectionViewDataSource, UICollectionViewDelegate  {
        
        @IBOutlet weak var rowTextField: UITextField!
        
        @IBOutlet weak var columnTextField: UITextField!
        
        @IBOutlet weak var matixCollectionView: UICollectionView!
    
        var grid = MinCost()

        var pickOption = [Int]()
        
        let pickerView = UIPickerView()
        
        var activeTextField:UITextField? = nil
    
        override public func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            //initilize picker options
            for index in 1...10 {
                pickOption.append(index)
            }
            
            //setup Collection view
            self.matixCollectionView.removeSpacingBetweenCells()
            
            //setup Picker View
            self.pickerView.delegate = self
            
            self.pickerView.dataSource = self;
            
            rowTextField.inputView = pickerView
            
            columnTextField.inputView = pickerView
            
        }
        
        override public func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - UITextfield protocol
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            
            if(textField == columnTextField || textField == rowTextField)
            {
                activeTextField = textField
                
                self.pickerView.selectRow(Int((activeTextField?.text)!)!-1, inComponent: 0, animated: true)
                
                if textField == columnTextField
                {
                    textField.addToolbar(title: "Select Column")
                }else
                {
                    textField.addToolbar(title: "Select Row")
                }
            }
            else{
                
                textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)

            }
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            
            if(textField == columnTextField || textField == rowTextField) {
                activeTextField = nil
                
                grid.initaliseMatrix(arr: [Int](),m: Int(rowTextField.text!)!, n: Int(columnTextField.text!)!)
                
                matixCollectionView?.reloadData()
            }
            else {
                // UICollection view cell
                let row = textField.tag / 1000;
                let col = textField.tag % 1000;
                print("row : \(row) :: col : \(col)")
                
                if(textField.text == nil){
                    textField.text = "0"
                }
                else if (textField.text?.characters.count == 0)
                {
                    textField.text = "0"
                }
                
                let value : Int = Int(textField.text!)!
                
                let node = grid.cost?[row, col]
                node?.val = value
            }
        }
    
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            if string == "" {
                return true
            }
            
            if (textField.text?.characters.count)! >= MAX_CHAR_LIMIT
            {
                return false
            }else
            {
                // Create an `NSCharacterSet` set which includes everything *but* the digits
                let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
                
                // At every character in this "inverseSet" contained in the string,
                // split the string up into components which exclude the characters
                // in this inverse set
                let components = string.components(separatedBy: inverseSet)
                
                // Rejoin these components
                let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
                
                // If the original string is equal to the filtered string, i.e. if no
                // inverse characters were present to be eliminated, the input is valid
                // and the statement returns true; else it returns false
                return string == filtered
            }
        }
        
        // MARK: - PickerView Datasource and Delegates
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickOption.count
        }
        
        public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(pickOption[row])"
        }
        
        public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            activeTextField?.text = String(pickOption[row])
        }
    
        // MARK: - UICollectionViewDelegate protocol
        
        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            let rowCount:Int? = Int(rowTextField.text!)
            return rowCount!;
        }
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let coloumnCount:Int = Int(columnTextField.text!) ?? 0
            return coloumnCount;
        }
        
        // make a cell for each cell index path
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let reuseIdentifier = "matrixCell" //enter this string as the cell identifier in the storyboard
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MatrixCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            
            let node = grid.cost?[indexPath.section,indexPath.item]
            
            var value = 0;
            
            if(node != nil) {
                value = (node?.val)!
            }

            cell.gridValueTF.text = String(value)
            cell.gridValueTF.textColor = UIColor.red
            cell.gridValueTF.delegate = self;
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.gridValueTF.tag = (1000 * indexPath.section) + indexPath.item;
            cell.gridValueTF.keyboardType = UIKeyboardType.numberPad
            cell.gridValueTF.addToolbar(title: "")
            return cell
        }
        
        @IBAction func actionOnSubmit(_ sender: Any)
        {
           let result = grid.getShortestPath();
            
           let alert = UIAlertController (title: "Output", message: "Total Cost : \(result.totalCost ) \n Path : \(result.sequence) ", preferredStyle:UIAlertControllerStyle.alert)
            
           let okAction = UIAlertAction (title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    
    
    @IBAction func actionOnClear(_ sender: Any) {
        
        grid.initaliseMatrix(arr: [Int](),m: Int(rowTextField.text!)!, n: Int(columnTextField.text!)!)
        
        matixCollectionView?.reloadData()
    }
}

