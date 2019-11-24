//
//  NewPictureViewController.swift
//  coloring_book
//
//  Created by Crystal Tang on 11/24/19.
//  Copyright © 2019 Crystal Tang. All rights reserved.
//

import UIKit

class NewPictureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var blockArray: [Block]!
    
    let blockCellReuseIdentifier = "blockCellReuseIdentifier"
    let padding: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Picture"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(dismissViewControllerAndSaveText))
        
        
        //create actual array with loop later on
        blockArray = []
        var num = 0
        while num < 100 {
            let x: Int = (num % 10) + 1
            let y: Int = num % 10
            let block = Block(code: 0, coordinateX: x, coordinateY: y)
            blockArray.append(block)
            num += 1
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BlockCollectionViewCell.self, forCellWithReuseIdentifier: blockCellReuseIdentifier)
        view.addSubview(collectionView)
        
        setUpConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: blockCellReuseIdentifier, for: indexPath) as! BlockCollectionViewCell
        let block = blockArray[indexPath.item]
        cell.configure(with: block)
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    //cell deleted NEEDS TO BE CHANGED
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let block = blockArray[indexPath.item]
        block.tapped()
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 9*padding)/10
        return CGSize(width: width, height: width)
    }
    
    //currently does not save picture
    @objc func dismissViewControllerAndSaveText() {
        // takes screenshot of image
        //        var image: UIImage = takeScreenshotAndSave()!
        //        //currently everything but image is empty
        //        var picture = Picture(name: "Name", preview: image, colorDictionary: [0: .white, 2: .black], blueprint: blockArray)
        // goes back to home page
        self.navigationController?.popViewController(animated: true)
    }
    
    open func takeScreenshotAndSave(_ shouldSave: Bool = true) -> String? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        //save image
        //return name of file
        return ""
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
