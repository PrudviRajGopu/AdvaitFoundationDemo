//
//  ImageDetailsVC.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 05/05/24.
//

import UIKit

class ImageDetailsVC: UIViewController {

 
    @IBOutlet weak var imgView: UIImageView!
    
    var selectedImg:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateView()
        
    }
    
    func updateView() {
        if selectedImg != nil {
            imgView.image = selectedImg

        }

        
    }
    
    
    
    @IBAction func backBtnAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
   

}
