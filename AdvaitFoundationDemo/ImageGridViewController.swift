//
//  ImageGridViewController.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 04/05/24.
//

import UIKit

class ImageGridViewController: UIViewController {

  
    @IBOutlet weak var gridCV: UICollectionView!
    private var imageURLs: [URL] = []
       
    let dataModel = ImageGridViewModel()
    var ImgDataArr:[ImageGridResponseElement] = []
  

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    
    func updateView() {
        
        gridCV.delegate = self
        gridCV.dataSource = self
        gridCV.register(UINib(nibName: "ImageGridCell", bundle: nil), forCellWithReuseIdentifier: "ImageGridCell")

        loadData()
    }
    
    
   
    

    @IBAction func backBtnAxn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func loadData() {
//        self.view.showActivityIndicator()
       
       self.dataModel.fetchImgData() { result in
       
           switch result {
           
           case .success(let data):
           
               self.ImgDataArr = data.model
                    DispatchQueue.main.async {
                        self.gridCV.reloadData()

                    }

                    print("Received data:", data.model)
                case .failure(let error):
                    self.showAlert(title: "Alert", message: error.localizedDescription)
                    print("Error:", error)
                }

            }
        
       
//       self.view.hideActivityIndicator()
        
    }
    

    
    private func constructImageURL(from thumbnail: Thumbnail) -> String {
           let baseURL = thumbnail.domain + "/" + thumbnail.basePath
           let imageURL = baseURL + "/0/" + thumbnail.key
           return imageURL
       }
    

}

extension ImageGridViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,ImageCellDelegate{
    func onTappingImg(img: UIImage) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailsVC") as! ImageDetailsVC
        VC.selectedImg = img
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImgDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGridCell", for: indexPath) as! ImageGridCell
        if ImgDataArr.isEmpty == false {
            let cellPath = ImgDataArr[indexPath.item]
            cell.delegate = self
            cell.updateCell(cellPath: cellPath)
           
        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
       
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.frame.width - 20) / 3
        let yourHeight = yourWidth

          return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}



