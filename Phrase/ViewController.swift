//
//  ViewController.swift
//  Phrase
//
//  Created by 江啟綸 on 2022/5/3.
//

import UIKit

class ViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var list = [PharseItem]()
    var currentType = 0
    
    //MARK: - Button Style
    // 客製化按鈕樣式
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
        
        title = "瘋言瘋語"
        view.backgroundColor = UIColor(named: "DBgGray")

        configureNavbar()
        getAllItems()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        // 讓cell可以拖動
        tableView.dragInteractionEnabled = true
        tableView.backgroundColor = UIColor(named: "DBgGray")
        
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
        
        
        navigationController?.navigationBar.tintColor = UIColor(named: "LabelC")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 80 , y: view.frame.size.height - 120, width: 60, height: 60)
        darkModeBtn.frame = CGRect(x: view.frame.size.width - 360, y: view.frame.size.height - 760, width: 60, height: 60)
        
    }
    
    @objc func Tap() {
        
//        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: UIAlertController.Style.alert)
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter Second Name"
//        }
//        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
//            let firstTextField = alertController.textFields![0] as UITextField
//
//            print("\(firstTextField.text!)")
//
//            if firstTextField.text == "" {
//                let emptyAlert = UIAlertController(title: "No Content", message: "", preferredStyle: UIAlertController.Style.alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                emptyAlert.addAction(okAction)
//
//                self.present(emptyAlert, animated: true, completion: nil)
//            }
//            else{
//                self.list.append(firstTextField.text!)
//                self.tableView.reloadData()
//            }
//
//        })
//
//
//        alertController.addAction(saveAction)
//
//        self.present(alertController, animated: true, completion: nil)
        
        // 利用alert的方式添加list所存儲的資料
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("ca")
        }))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
                return
            }
            
            self?.createItem(name: text)
            
        }))
        
        
        present(alert, animated: true)
        
        
    }
    
    // 跳轉到別的VC
    @objc func nextVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "sec") as! secViewController
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
    
    // 淺色模式
    func lightMode(){
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "DBgGray")]


        navigationController?.navigationBar.tintColor = UIColor(named: "DBgGray")
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]

        
        darkModeBtn.backgroundColor = UIColor(named: "lightP")
        let image = UIImage(systemName: "moon.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .medium))
        darkModeBtn.setImage(image, for: .normal)
        darkModeBtn.tintColor = .white
        view.backgroundColor = UIColor(named: "LBgGray")
        tableView.backgroundColor = UIColor(named: "LBgGray")
        

        tableView.reloadData()
    }
    
    // 深色模式
    func darkMode(){

        navigationController?.navigationBar.tintColor = UIColor(named: "LabelC")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "LBgGray")]
        

        darkModeBtn.backgroundColor = UIColor(named: "lightY")
        let image = UIImage(systemName: "sun.max",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .medium))
        darkModeBtn.setImage(image, for: .normal)
        darkModeBtn.tintColor = .black
        view.backgroundColor = UIColor(named: "DBgGray")
        tableView.backgroundColor = UIColor(named: "DBgGray")
        
        tableView.reloadData()
        
    }
    
    // 判斷現在是哪個模式的func
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
    
    // CoreData
    
    func getAllItems() {
        
        do {
            list = try context.fetch(PharseItem.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            // error
        }
        
    }
    
    func createItem(name: String) {
        let newItem = PharseItem(context: context)
        newItem.name = name
        newItem.createAt = Date()
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    
    func deleteItem(item: PharseItem) {
        context.delete(item)
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    
    func updateItem(item: PharseItem, newName: String) {
        item.name = newName
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
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
        let lists = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! SubTableViewCell
        cell.textKK.text = lists.name
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = list[indexPath.row]
        
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else{
                    return
                }
                
                self?.updateItem(item: item, newName: newName)
                
            }))
            
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
    
    
    
    
    
  
}

