//
//  ViewController.swift
//  coloring_book
//
//  Created by Crystal Tang on 11/24/19.
//  Copyright © 2019 Crystal Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    
    let pictureCellReuseIdentifier = "pictureCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    let padding: CGFloat = 10
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Crystal's Coloring Book"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushNewPictureViewController))
        
        
        let pic = Picture(name: "Pic", preview: "pic", colorDictionary: [:], blueprint: [])
        GlobalVariables.pictureArray = [pic, pic, pic, pic]
        
        print("inital")
        dump(GlobalVariables.pictureArray)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: pictureCellReuseIdentifier)
        view.addSubview(collectionView)
        
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureCellReuseIdentifier, for: indexPath) as! PictureCollectionViewCell
        let picture = GlobalVariables.pictureArray[indexPath.item]
        cell.configure(with: picture)
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalVariables.pictureArray.count
    }
    
    //cell is deleted, NEEDS TO BE CHANGED
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GlobalVariables.pictureArray.remove(at: indexPath.item)
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - padding)/2.0
        return CGSize(width: width, height: width)
    }
    
    @objc func pushNewPictureViewController() {
        print("pushNewPictureVC before")
        dump(GlobalVariables.pictureArray)
        let newPictureViewController = NewPictureViewController()
        navigationController?.pushViewController(newPictureViewController, animated: true)
        print("pushNewPictureVC after")
        dump(GlobalVariables.pictureArray)
    }
    
    //    func setNavigationBar() {
    //        let screenSize: CGRect = UIScreen.main.bounds
    //        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
    //        let navItem = UINavigationItem(title: title!)
    //        navBar.setItems([navItem], animated: false)
    //        self.view.addSubview(navBar)
    //    }
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    //        let screenSize: CGRect = UIScreen.main.bounds
    //        let screenWidth = screenSize.width
    //        return CGSize(width: (screenWidth/3)-6, height: (screenWidth/3)-6);
    //    }
    
}

