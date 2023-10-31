//
//  allMenuVC.swift
//  Spacial OClock
//
//  Created by cqlios on 31/10/23.
//

import UIKit
import SDWebImage

class allMenuVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - VARIABLES
    var viewmodal = HomeViewModel()
    var modal : [allMenuModalBody]?
    var restoid = Int()
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchdata()
    }
    
    //MARK: - FUNCTION
    func fetchdata(){
        viewmodal.allMenu_API(resto_bar_id: restoid) { [weak self] data in
            self?.modal =  data
            self?.collectionView.reloadData()
        }
    }
    //MARK: - ACTIONS
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - EXTENSIONS
extension allMenuVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modal?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allMenuCVC", for: indexPath) as! allMenuCVC
        let imageIndex = (self.modal?[indexPath.row].baseurl ?? "") + (self.modal?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgView.sd_setImage(with: URL(string: imageIndex), placeholderImage: UIImage(named: "rectAlbum"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1, height: 166)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "fullImageView") as! fullImageView
        vc.settype = 1
        vc.url = self.modal?[indexPath.row].baseurl ?? ""
        vc.setImage = self.modal?[indexPath.row].image ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
