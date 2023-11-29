//
//  RestoCardListVC.swift
//  Spacial OClock
//
//  Created by cqlios on 03/07/23.
//

import UIKit
struct ModelCardData{
    var img : String
    var check : Bool
}

class RestoCardListVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var btnAddCard : UIButton!
    @IBOutlet weak var tbCard : UITableView!
    
    //MARK: - VARIABLES
    var arrCard : [ModelCardData] = [ModelCardData(img : "visaCard1", check: false),
                                     ModelCardData(img : "creditCard", check: false)]
    var viewmodel = restoViewModal()
    var datagetAPI : [CardListingModelBody]?
    var cardId =  Int()
    var imageView: UIImageView?
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
      
        btnAddCard.layer.borderWidth = 1
        btnAddCard.layer.borderColor = UIColor.systemGray5.cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        CardlistingApi()
    }
    //MARK: - FUNCTION NO DATA FOUND
    func showBackgroundGIF() {
        let gifURL = Bundle.main.url(forResource: "NodataFound", withExtension: "gif") // Replace "noDataGif" with the name of your GIF file
        
        if let gifURL = gifURL, let gifData = try? Data(contentsOf: gifURL), let source = CGImageSourceCreateWithData(gifData as CFData, nil) {
            let frameCount = CGImageSourceGetCount(source)
            var images: [UIImage] = []
            
            for i in 0..<frameCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    let uiImage = UIImage(cgImage: cgImage)
                    images.append(uiImage)
                }
            }
            
            imageView = UIImageView(frame: tbCard.bounds)
            imageView?.animationImages = images
            imageView?.animationDuration = TimeInterval(frameCount) * 0.1 // Adjust the animation speed if needed
            imageView?.animationRepeatCount = 0 // Repeat indefinitely
            imageView?.contentMode = .scaleAspectFit
            imageView?.startAnimating()
            
            tbCard.backgroundView = imageView
            tbCard.separatorStyle = .none
        }
    }
    
    func removeBackgroundGIF() {
        imageView?.stopAnimating()
        tbCard.backgroundView = nil
        tbCard.separatorStyle = .singleLine
    }
    //MARK: - API CARD LISTING
    func CardlistingApi(){
        self.viewmodel.cardListing { data in
            self.datagetAPI?.removeAll()
            self.datagetAPI = data
            self.tbCard.reloadData()
            if self.datagetAPI?.count == 0 {
                self.showBackgroundGIF()
                
            } else {
                self.removeBackgroundGIF()
                
            }
        }
    }
    //MARK: - ACTINOS
    @IBAction func btnAddCard(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProAddCardVc") as! ProAddCardVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnUpdaet(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackAct(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: - EXTENSIONS
extension RestoCardListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datagetAPI?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restoCardListTVC", for: indexPath) as! restoCardListTVC
//        cell.lblcardnumber.text = "XXXXXXXXXXX\(datagetAPI?[indexPath.row].cardNumber?.description ?? "")"
//        cell.btndelete.addTarget(self, action: #selector(btndelete), for: .touchUpInside)
//        cell.btnCell.addTarget(self, action: #selector(btnCardTarget), for: .touchUpInside)
//        cell.btnCell.tag = indexPath.row
//        cell.btndelete.tag = indexPath.row
        return cell
    }
//    @objc func btndelete(_ sender : UIButton){
//        viewmodel.cardDelete(card_id: datagetAPI?[sender.tag].id ?? 0) { data in
//        self.CardlistingApi()
//        }
//
//    }
}
extension RestoCardListVC {
    @objc func btnCardTarget(_ sender : UIButton){
//        if sender.isSelected == false{
//            arrCard[sender.tag].check = true
//        }else{
//            arrCard[sender.tag].check = false
//        }
        tbCard.reloadData()
    }
}
