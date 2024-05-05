//
//  ViewController.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 04/05/24.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var sliderCV: UICollectionView!
    
    @IBOutlet weak var pageInd: UIPageControl!
    
    @IBOutlet weak var startBtn: UIButton!
    var sliderImgArr:[String] = ["slider1","slider2","slider3","slider4"]
    override func viewDidLoad() {
        super.viewDidLoad()



        updateView()
    }

    func updateView() {
        
        sliderCV.delegate = self
        sliderCV.dataSource = self
        startBtn.layer.cornerRadius = 10
        sliderCV.isPagingEnabled = true
        pageInd.numberOfPages = sliderImgArr.count
        pageInd.currentPage = 0
        self.sliderCV.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")

    }
    
    
    @IBAction func startBtnAxn(_ sender: UIButton) {
        let gridVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageGridViewController") as! ImageGridViewController
        
        self.navigationController?.pushViewController(gridVC, animated: true)
    }
    
    

}
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
        
        
        cell.imageView.image = UIImage(named: sliderImgArr[indexPath.item])
        cell.imageView.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        pageInd.currentPage = indexPath.item
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: sliderCV.bounds.width - 10, height: sliderCV.bounds.height)
        
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth = scrollView.frame.width
            let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
            pageInd.currentPage = currentPage
        }
}
