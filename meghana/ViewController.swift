//
//  ViewController.swift
//  meghana
//
//  Created by Meghna on 04/08/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var Numbers: [String] = ["10", "20", "30", "40", "50" ,"60","70","80","90","100"]
    let cellReuseIdentifier = "cell"
    var array_name = [String]()
    var New_array : [String] = ["05"]
    
    var toolBar_done = UIToolbar()
    var picker  = UIPickerView()
    
    var toolBar_cancel = UIToolbar()

    @IBOutlet weak var home_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Practical"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        self.home_tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        home_tableview.delegate = self
        home_tableview.dataSource = self
        home_tableview.tableFooterView = UIView()
    }
    
    @objc func addTapped() {
        picker = UIPickerView.init()
            picker.delegate = self
            picker.dataSource = self
            picker.backgroundColor = UIColor.white
            picker.setValue(UIColor.black, forKey: "textColor")
            picker.autoresizingMask = .flexibleWidth
            picker.contentMode = .center
            picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(picker)
                    
        toolBar_done = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar_done.barStyle = .default
        toolBar_done.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar_done)
        
        toolBar_cancel = UIToolbar.init(frame: CGRect.init(x: 280, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar_cancel.barStyle = .default
        toolBar_cancel.items = [UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(onCancelButtonTapped))]
        self.view.addSubview(toolBar_cancel)
        
        
       }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.New_array.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell:UITableViewCell = (self.home_tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
            self.New_array.sort()
           cell.textLabel?.text = self.New_array[indexPath.row]
            return cell
            
        }
     
     func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {

        let action = UIContextualAction(
                style: .normal,
                title: "Delete",
            handler: { [self] (action, view, completion) in
                let new_value = self.New_array[indexPath.row]
                self.array_name.insert(new_value, at: 0)
                    self.New_array.remove(at: indexPath.row)
                            self.home_tableview.reloadData()
                                    completion(true)
            })

            action.backgroundColor = .red
            let configuration = UISwipeActionsConfiguration(actions: [action])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
     }
    @objc func onCancelButtonTapped(){
        toolBar_done.removeFromSuperview()
        picker.removeFromSuperview()
        toolBar_cancel.removeFromSuperview()
    }

    @objc func onDoneButtonTapped() {
        toolBar_done.removeFromSuperview()
        toolBar_cancel.removeFromSuperview()
        picker.removeFromSuperview()
        self.home_tableview.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Numbers.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Numbers[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        New_array.insert(Numbers[row] , at: 0)
        
    }
}

