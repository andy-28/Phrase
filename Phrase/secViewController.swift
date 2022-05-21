//
//  secViewController.swift
//  Phrase
//
//  Created by 江啟綸 on 2022/5/8.
//

import UIKit

class secViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    private let lastBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let image = UIImage(systemName: "lessthan",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = UIColor(named: "lightP")
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func BtnClicktopage(_ sender: Any) {
        performSegue(withIdentifier: "ToPage2", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.list.append(textView.text!)
        vc.tableView?.reloadData()
        
    }
    
    
    @objc func Tap() {
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "first") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
       
    }
    
    
    
}
