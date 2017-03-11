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
    
        var grid = matrixGrid()

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
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            
            if(textField == columnTextField || textField == rowTextField) {
                activeTextField = nil
                
                grid.initaliseMatrix(arr: [String](),m: Int(rowTextField.text!)!, n: Int(columnTextField.text!)!)
                
                matixCollectionView?.reloadData()
            }
            else {
                // UICollection view cell
                let row = textField.tag / 1000;
                let col = textField.tag % 1000;
                print("row : \(row) :: col : \(col)")
                grid.cost?[row, col] = textField.text!
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
                return true
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
            cell.gridValueTF.text = grid.cost?[indexPath.section,indexPath.item]
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
            
            let output = grid.getShortestPath();
            
            var message : String = ""
           
            if(output.sucess){
                print(output.pathGirdWay);
                print(output.totalCost);
                print(output.sequence);
                message = "Cost : \(output.totalCost)"
            }
            else{
                print(output.errorMessage);
                message = output.errorMessage;
            }
            
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        
}

