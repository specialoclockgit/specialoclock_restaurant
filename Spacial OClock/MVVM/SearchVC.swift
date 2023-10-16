//
//  SearchVC.swift
//  Spacial OClock
//
//  Created by cqlios on 16/10/23.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imgViewGif: UIImageView!
    @IBOutlet weak var searchCV: UICollectionView!
    @IBOutlet weak var txtFldSearch: CustomTextField!
    
    //MARK: - VARIABLES
    
    //MARK: - VIEW LFIECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - FUNCTIONS
    
    
    //MARK: - ACTIONS

}
//MARK: - EXTENSIONS
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCV.dequeueReusableCell(withReuseIdentifier: "SearchCVC", for: indexPath) as! SearchCVC
        return cell
    }
}
