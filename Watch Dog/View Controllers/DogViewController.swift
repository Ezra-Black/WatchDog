//
//  DogMainViewController.swift
//  Watch Dog
//
//  Created by Nick Nguyen on 2/16/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class DogViewController: UIViewController  {
    
 
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.becomeFirstResponder()
        }
    }
    
    var isSearch = false
    var filteredDog = [Dog]()
    
    let dogController = DogController()
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
                  collectionView.delegate = self
        DispatchQueue.main.async {
            self.dogController.fetchAllDogsImage { (action) in
                print(self.dogController.dogs.count)
            }
        }
  
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
          view.addGestureRecognizer(tap)
    }
    

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
}

extension DogViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return filteredDog.count
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCell", for: indexPath) as? DogCollectionViewCell
            else { return UICollectionViewCell() }
        
        self.dogController.fetchAllDogsImage { _ in
            DispatchQueue.main
                .async {
                    cell.dogImageView.load(url: URL(string: self.dogController.dogs[indexPath.item].image)!)
            }
        }
                return cell
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("HAhaha")
    }
    
}

extension DogViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
