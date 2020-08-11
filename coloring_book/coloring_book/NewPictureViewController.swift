//
//  NewPictureViewController.swift
//  coloring_book
//
//  Created by Crystal Tang on 11/24/19.
//  Copyright © 2019 Crystal Tang. All rights reserved.
//
//  Specs: New Picture View Controller

import UIKit

class NewPictureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var blockArray: [Block]!
    
    let blockCellReuseIdentifier = "blockCellReuseIdentifier"
    let padding: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Picture"
            
        print("viewDidLoad")
        dump(ViewController().pictureArray)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(dismissViewControllerAndSave))
        
        
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
    @objc func dismissViewControllerAndSave() {
        // takes screenshot of image
        //doesnt work because unwrapping nil
//        let picture = Picture(name: "Name", preview: ()!, colorDictionary: [0: .white, 1: .black], blueprint: blockArray)
//        takeScreenshotAndSave()
        // add picture to array
        print("save before")
        dump(ViewController().pictureArray)
        let picture = Picture(name: "NewPic", preview: "pic", colorDictionary: [:], blueprint: [])
        let viewController = ViewController()
        viewController.addPicture(pic: picture)
        print("save after")
        dump(viewController.pictureArray)
        // goes back to home page
        self.navigationController?.popViewController(animated: true)
    }
    
//    @objc func pushNewPictureViewController() {
//        let newPictureViewController = NewPictureViewController()
//        navigationController?.pushViewController(newPictureViewController, animated: true)
//    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
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
        saveImage(image: screenshotImage!)
        return screenshotImage
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("fileName.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
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
