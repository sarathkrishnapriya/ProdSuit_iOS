//
//  LMCategoryDetailsImageVC.swift
//  ProdSuit
//
//  Created by MacBook on 19/05/23.
//

import UIKit
import Combine

protocol LocationImageApiDelegate:AnyObject {
    
    var parserVm:GlobalAPIViewModel! { get set }
    var apiParserVm :  APIParserManager! { get set }
    
    func locationImageAPICall(_ ID_LeadGenerate:String,_ ID_LeadGenerateProduct:String,_ fk_employee:String)
}

class LMCategoryDetailsImageVC: UIViewController,LocationImageApiDelegate{
   
    
    
    @IBOutlet weak var imageShowingCV: UICollectionView!
    var apiParserVm: APIParserManager!

    var parserVm: GlobalAPIViewModel!
    
    lazy var imageCancellable = Set<AnyCancellable>()
    
    var imageList : [String] = []{
        didSet{
            self.imageShowingCV.reloadData()
        }
    }
    
    var size : CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiParserVm = APIParserManager()
        self.parserVm = GlobalAPIViewModel(bgView: self.view)
        
        self.imageShowingCV.dataSource = self
        self.imageShowingCV.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    
    func locationImageAPICall(_ ID_LeadGenerate:String,_ ID_LeadGenerateProduct:String,_ fk_employee:String) {
        
        
        let requestMode = RequestMode.shared.leadLocationAndImage
        let token = preference.User_Token
        let bankKey = preference.appBankKey
        let fk_company = "\(preference.User_FK_Company)"
        let fk_Employee = fk_employee
        let id_LeadGenerate = ID_LeadGenerate
        let leadGenerateProduct_id = ID_LeadGenerateProduct
        
        if let erequestMode = instanceOfEncryptionPost.encryptUseDES(requestMode, key: SKey),
           let ebankKey = instanceOfEncryptionPost.encryptUseDES(bankKey, key: SKey),
           let etoken = instanceOfEncryptionPost.encryptUseDES(token, key: SKey),
           
            let efk_Employee = instanceOfEncryptionPost.encryptUseDES(fk_Employee, key: SKey),
           let eid_LeadGenerate = instanceOfEncryptionPost.encryptUseDES(id_LeadGenerate, key: SKey),
           let efk_company = instanceOfEncryptionPost.encryptUseDES(fk_company, key: SKey),
           let eProductId = instanceOfEncryptionPost.encryptUseDES(leadGenerateProduct_id, key: SKey){
           
            
            let arguMents = ["ReqMode":erequestMode,"BankKey":ebankKey,"Token":etoken,"FK_Company":efk_company,"ID_LeadGenerateProduct":eProductId,"ID_LeadGenerate":eid_LeadGenerate,"FK_Employee":efk_Employee]
            let request = apiParserVm.request(urlPath: URLPathList.Shared.leadLocationAndImage,arguMents: arguMents)
           
                parserVm.modelInfoKey = "LeadImageDetails"
                //parserVm.progressBar.showIndicator()
                parserVm.parseApiRequest(request)
                parserVm.$responseHandler
                .dropFirst()
                .sink { responseHandler in
                    //self.parserVm.progressBar.hideIndicator()
                    let statusCode = responseHandler.statusCode
                    let message = responseHandler.message
                    
                    if statusCode == 0{
                        
                        let imageOne = responseHandler.info.value(forKey: "LocationLandMark1") as? String ?? ""
                        
                        let imageTwo = responseHandler.info.value(forKey: "LocationLandMark2") as? String ?? ""
                        
                        self.imageList = []
                        
                        if imageOne != ""{
                            self.imageList.append(imageOne)
                        }
                        
                        if imageTwo != ""{
                            self.imageList.append(imageTwo)
                        }
                        
                    }else{
                       print("lead info : \(message)")
                    }
                    
                    print(responseHandler.info)
                    self.imageCancellable.dispose()
                }.store(in: &imageCancellable)
            
        }
        
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

extension LMCategoryDetailsImageVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lMUploadImageDetailsCVC", for: indexPath) as! LMUploadImageDetailsCVC
        
        let imageInfo = self.imageList[indexPath.row]
        
        if let imageData = Data.init(base64Encoded: imageInfo){
        cell.uploadImageView.contentMode = .scaleAspectFill
            cell.uploadImageView.backgroundColor = UIColor.green
            let image = UIImage.init(data: imageData)?.resizeImage(image: UIImage.init(data: imageData)!, targetSize: size)
        cell.uploadImageView.image = image
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemCount = self.imageList.count
        let numberOfCellInRow = 2
        let reminder =  itemCount % 2 == 0 ? 0 : 1
        let numberOfColoumn = ((itemCount - reminder)/2) + reminder
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
      
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellInRow))
        
        let totalHeightSpace = flowLayout.sectionInset.top + flowLayout.sectionInset.bottom + flowLayout.minimumLineSpacing * CGFloat(numberOfColoumn - 1)
        
        let heightSize = Int((collectionView.bounds.height - totalHeightSpace) / CGFloat(numberOfColoumn))
        self.size = CGSize(width: size, height: size)
        return CGSize(width: size, height: size)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
    
}
