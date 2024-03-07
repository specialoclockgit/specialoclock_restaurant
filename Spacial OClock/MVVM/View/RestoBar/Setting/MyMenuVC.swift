//
//  MyMenuVC.swift
//  Spacial OClock
//
//  Created by cql99 on 27/06/23.
//

import UIKit

class MyMenuVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: - VARIABLES
    var viewmodel = restoViewModal()
    var datagetApi: [MenuListingModelBody]?
    var imageView: UIImageView?
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.SetupAPI()
    }
    //MARK: - API MENU
    func SetupAPI(){
        viewmodel.getMenuapi(resotbarid: Store.userDetails?.bussiness_id ?? 0) { [weak self] data in
            self?.datagetApi = data
            self?.tblView.reloadData()
            if self?.datagetApi?.count == 0 {
                self?.showBackgroundGIF()
            } else {
                self?.removeBackgroundGIF()
                
            }
        }
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
            
            imageView = UIImageView(frame: tblView.bounds)
            imageView?.animationImages = images
            imageView?.animationDuration = TimeInterval(frameCount) * 0.1 // Adjust the animation speed if needed
            imageView?.animationRepeatCount = 0 // Repeat indefinitely
            imageView?.contentMode = .scaleAspectFit
            imageView?.startAnimating()
            
            tblView.backgroundView = imageView
            tblView.separatorStyle = .none
        }
    }
    
    func removeBackgroundGIF() {
        imageView?.stopAnimating()
        tblView.backgroundView = nil
        tblView.separatorStyle = .singleLine
    }
    //MARK: - ACTIONS
    @IBAction func btnActBack(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddMenuAct(_ sender : UIButton){
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.AddMenuVc) as! AddMenuVc
        self.navigationController?.pushViewController(screen, animated: true)
    }
}

//MARK: - EXTENSIONS
extension MyMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datagetApi?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMenuTvc", for: indexPath) as! MyMenuTvc
        cell.lblName.text = datagetApi?[indexPath.row].name.capitalized ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: ViewController.BreakfastVC) as! BreakfastVC
        screen.heading = datagetApi?[indexPath.row].name.capitalized ?? ""
        screen.menuid =  datagetApi?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
