//
//  ViewController.swift
//  Phrase
//
//  Created by 江啟綸 on 2022/5/3.
//

import UIKit

class ViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!

    var list = [String]()
    var currentType = 0
    
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let image = UIImage(systemName: "square.and.pencil",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = UIColor(named: "lightG")
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let darkModeBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let image = UIImage(systemName: "sun.max",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = UIColor(named: "lightY")
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "瘋言瘋語"
        view.backgroundColor = UIColor(named: "GGray")
        
        configureNavbar()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.backgroundColor = UIColor(named: "GGray")
        
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(Tap), for: .touchUpInside)
        view.addSubview(darkModeBtn)
        darkModeBtn.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        
        tableView.rowHeight = 100
        
    }
    
    private func configureNavbar() {
        let image = UIImage(systemName: "ellipsis",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(nextVC))
        
        
        navigationController?.navigationBar.tintColor = UIColor(named: "C1")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 80 , y: view.frame.size.height - 120, width: 60, height: 60)
        darkModeBtn.frame = CGRect(x: view.frame.size.width - 360, y: view.frame.size.height - 760, width: 60, height: 60)
        
    }
    
    @objc func Tap() {
        
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Second Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            
            print("\(firstTextField.text!)")
            
            if firstTextField.text == "" {
                let emptyAlert = UIAlertController(title: "No Content", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                emptyAlert.addAction(okAction)
                
                self.present(emptyAlert, animated: true, completion: nil)
            }
            else{
                self.list.append(firstTextField.text!)
                self.tableView.reloadData()
            }
            
        })
        
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func nextVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "sec") as! secViewController
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
    
    func lightMode(){
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        navigationController?.navigationBar.tintColor = UIColor(named: "GGray")
        
        darkModeBtn.backgroundColor = UIColor(named: "lightP")
        let image = UIImage(systemName: "moon.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .medium))
        darkModeBtn.setImage(image, for: .normal)
        darkModeBtn.tintColor = .white
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        tableView.reloadData()
    }
    
    func darkMode(){
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "C1")]

        
        navigationController?.navigationBar.tintColor = UIColor(named: "C1")
        
        darkModeBtn.backgroundColor = UIColor(named: "lightY")
        let image = UIImage(systemName: "sun.max",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .medium))
        darkModeBtn.setImage(image, for: .normal)
        darkModeBtn.tintColor = .black
        view.backgroundColor = UIColor(named: "GGray")
        
        
        
        tableView.backgroundColor = UIColor(named: "GGray")
        tableView.reloadData()
        
    }
    
    @objc func changeMode() {
        
        currentType += 1
        
        if currentType > 1 {
            currentType = 0
        }
        
        switch currentType {
        case 0:
            darkMode()
            
        case 1:
            lightMode()
                
        default:
            break

        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! SubTableViewCell
        cell.textKK.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = list[indexPath.row]
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        let mover = list.remove(at: sourceIndexPath.row)
        list.insert(mover, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    
    
    
    
  
}

