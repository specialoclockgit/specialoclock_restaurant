//
//  WalkthroughVideoVC.swift
//  Spacial OClock
//
//  Created by cqlm2 on 21/06/24.
//

import UIKit
import CHIPageControl
import AVKit
import AVFoundation


class WalkthroughVideoVC: UIViewController {
    @IBOutlet weak var collVw: UICollectionView!
    
    @IBOutlet weak var pgController: CHIPageControlJaloro!
    var selectIndex = 0
    var visibleIndex = 0
    var imgArr = [UIImage(named: ""),UIImage(named: "walk2"),UIImage(named: "walk3"),UIImage(named: "walk4")]
    var titleArr = ["","User Signup Process","Signup as Restaurant, Bar or Club","Join Our Growing Network"]
    var subtitleArr = ["Welcome to Special O’Clock! We help you find the best discounts and specials at restaurants, bars and clubs.","Join Special O’Clock as a user to start enjoying exclusive deals at your favorite spots. Select 'User' and follow the steps to create your account. Discovering great deals has never been easier!","Join Special O’Clock as a restaurant, bar, or club to offer your special deals and attract more customers during off-peak times. Select your business type, complete the signup process, and become part of a community dedicated to making every moment special. Increase your visibility and fill those empty seats!","Become a partner with Special O’Clock and take advantage of our platform to attract more customers during off-peak hours. List your special deals and offers, increase your visibility, and fill your tables with ease."]
    override func viewDidLoad() {
        super.viewDidLoad()
        collVw.delegate = self
        collVw.dataSource = self
        
        pgController.tintColor = .white
        pgController.currentPageTintColor = .white
        pgController.inactiveTransparency = 0.5
        if UserDefaults.standard.value(forKey: "AppInstalled") as? Bool == true {
            let storyb = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyb.instantiateViewController(withIdentifier: "SelectVC") as! SelectVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    @IBAction func tapNextBtn(_ sender: UIButton) {
        if selectIndex == 0 {
            let nextItem: IndexPath = IndexPath(item: visibleIndex + 1, section: 0)
            self.collVw.scrollToItem(at: nextItem, at: .left, animated: true)
        } else if selectIndex == 1 {
            let nextItem: IndexPath = IndexPath(item: visibleIndex + 1, section: 0)
            self.collVw.scrollToItem(at: nextItem, at: .left, animated: true)
        } else if selectIndex == 2 {
            let nextItem: IndexPath = IndexPath(item: visibleIndex + 1, section: 0)
            self.collVw.scrollToItem(at: nextItem, at: .left, animated: true)
        }else {
            let vc = self.storyboard?.instantiateViewController(identifier: "SelectVC") as! SelectVC
            UserDefaults.standard.setValue(true, forKey: "AppInstalled")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        collVw.reloadData()
    }
    
    
}
extension WalkthroughVideoVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkthroughVideoCVC", for: indexPath) as! WalkthroughVideoCVC
        cell.imgVw.image = indexPath.row == 0 ? UIImage(named: "") : UIImage(named: "walkBg")
       
        cell.titleLbl.text = titleArr[indexPath.row]
        cell.subTitleLbl.text = subtitleArr[indexPath.row]
        cell.deviceImgVw.image = imgArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? WalkthroughVideoCVC {
            if indexPath.row == 0 {
                cell.bgVw.isHidden = false
                cell.playVideo()
            }else {
                cell.bgVw.isHidden = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? WalkthroughVideoCVC {
            cell.bgVw.isHidden = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        let roundedIndex = round( index )
        self.visibleIndex = Int(roundedIndex)
        self.selectIndex = Int(roundedIndex)
        //pgController.progress = roundedIndex
        pgController.set(progress: Int(roundedIndex), animated: true)
    }
    func navigateToNewScreen() {
        let screen =  storyboard?.instantiateViewController(withIdentifier: "SelectVC") as! SelectVC
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}


class WalkthroughVideoCVC :  UICollectionViewCell {
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var deviceImgVw: UIImageView!
    
    
    func playVideo(){
        DispatchQueue.main.async {
            let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Specialoclockanimation", ofType: "mp4")!))
            let layer = AVPlayerLayer(player: player)
            layer.frame = self.bgVw.bounds
            layer.videoGravity = .resizeAspectFill
            self.bgVw.layer.addSublayer(layer)
            player.volume = 0
            player.isMuted = true
            player.play()
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                player.seek(to: CMTime.zero)
                player.play()
            }
        }
     
    }
    
//    @objc func playerItemDidReachEnd(notification: NSNotification) {
//        player.seek(to: CMTime.zero)
//        player.play()
//    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
