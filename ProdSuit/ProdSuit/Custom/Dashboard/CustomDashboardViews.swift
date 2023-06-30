//
//  CustomDashboardViews.swift
//  ProdSuit
//
//  Created by MacBook on 06/03/23.
//

import Foundation
import UIKit


class NavGradientview:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   
        override func draw(_ rect: CGRect) {

            // Setup view
            let colors = [UIColor.white.cgColor, UIColor.black.cgColor] as CFArray
            let locations = [ 0.0, 1.0 ] as [CGFloat]
            let radius = min((self.bounds.size.height), (self.bounds.size.width))
            let center = CGPoint.init(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)

            // Prepare a context and create a color space
            let context = UIGraphicsGetCurrentContext()
            context!.saveGState()
            let colorSpace = CGColorSpaceCreateDeviceRGB()

            // Create gradient object from our color space, color components and locations
            let gradient = CGGradient.init(colorsSpace: colorSpace, colors: colors, locations: locations)

            // Draw a gradient
            context!.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
            context?.restoreGState()
        }
    }


class MenuBgView:UIView{
    
    
    var shapLayar = CAShapeLayer()
    
    
    let topView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.Shared.colorPrimary
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        
        let size = self.bounds.size
        
        let p1 = self.bounds.origin
        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
        let p3 = CGPoint(x: p2.x - 80, y: size.height/2)
        let p4 = CGPoint(x: size.width, y: size.height)
        let p5  = CGPoint(x: p1.x, y: size.height)
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addQuadCurve(to: CGPoint(x: p2.x, y: size.height), controlPoint: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.close()

        AppColor.Shared.colorPrimary.set()
        path.fill()
        shapLayar.path = path.cgPath
        shapLayar.masksToBounds = true
        shapLayar.fillColor = AppColor.Shared.coloBlack.withAlphaComponent(0.40).cgColor
        //self.subviews[0].subviews[0].backgroundColor = UIColor.orange
        
        self.layer.insertSublayer(shapLayar, at: 0)
        
    }
    
    
}

class SidemenuTableVieWs:UITableView{
    
    var shapLayar = CAShapeLayer()
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let size = self.bounds.size
        
        let p1 = self.bounds.origin
        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
        let p3 = CGPoint(x: p2.x - 80, y: size.height/2)
        let p4 = CGPoint(x: size.width, y: size.height)
        let p5  = CGPoint(x: p1.x, y: size.height)
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addQuadCurve(to: CGPoint(x: p2.x, y: size.height), controlPoint: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.close()

        AppColor.Shared.colorPrimary.set()
        path.fill()
        shapLayar.path = path.cgPath
        shapLayar.masksToBounds = true
        shapLayar.fillColor = AppColor.Shared.coloBlack.withAlphaComponent(0.40).cgColor
        //self.subviews[0].subviews[0].backgroundColor = UIColor.orange
        
        self.layer.insertSublayer(shapLayar, at: 1)
        
    }
}


class PentagonView:UIView{
    
    var shapLayar = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        
//        let size = self.bounds.size
//
//        let height:CGFloat = 140
        
//        let p1 = self.bounds.origin
//        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
//        let p3 = CGPoint(x: p2.x, y: p2.y + height - 50)
//        let p4 = CGPoint(x:size.width/2, y:size.height)
//        let p5 = CGPoint(x:p1.x, y:height - 50)
        
        // create the path
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        
//               path.move(to: p1)
//               path.addLine(to: p2)
//               path.addLine(to: p3)
//               path.addLine(to: p4)
//               path.addLine(to: p5)
//               path.close()

               // fill the path
               AppColor.Shared.colorPrimary.set()
               path.fill()
               shapLayar.path = path.cgPath
        shapLayar.masksToBounds = true
        shapLayar.fillColor = UIColor.clear.cgColor
        self.layer.insertSublayer(shapLayar, at: 0)
    }
}


class ImageSliderView:UIView,UIScrollViewDelegate{
    
    var count : Int = 0
    var offSet: CGFloat = 0
    var currentPage = 0
    
    private let pageControll = UIPageControl()
    
    private var timer : DispatchSourceTimer?
    
    lazy var imageScrollView : UIScrollView = {
       
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.systemYellow
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        
        
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sliderInitializer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        sliderInitializer()
    }
    
    func sliderInitializer(){
        
        self.setCornerRadius(size: 5)
        self.addSubview(pageControll)
        //pageControll.backgroundColor = UIColor.red
        self.addSubview(imageScrollView)
        var scrollviewConstraint = [NSLayoutConstraint]()
        
        scrollviewConstraint.append(imageScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        scrollviewConstraint.append(imageScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        scrollviewConstraint.append(imageScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        scrollviewConstraint.append(imageScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(scrollviewConstraint)
        
        
          
         
//
//
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        var homePageControlAnchor = [NSLayoutConstraint]()
        //pageControll.backgroundColor = UIColor.systemBlue
        homePageControlAnchor.append(pageControll.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        homePageControlAnchor.append(pageControll.heightAnchor.constraint(equalToConstant: 30))
        homePageControlAnchor.append(pageControll.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0))

        NSLayoutConstraint.activate(homePageControlAnchor)
        
        self.bringSubviewToFront(pageControll)
        
        
    }
    
    func slidePageInitilizer(imageCounts:Int,imageList:[BannerDetailItemModel],parserVM:GlobalAPIViewModel)  {
        let imageCount = imageCounts
        let scrollTotawidth = self.frame.width * CGFloat(imageCount)
        let height = self.imageScrollView.frame.size.height
        self.count = imageCounts
        //let scrollY = imageScrollView.frame.origin.y
        let contentWidth = self.frame.width
        var x : CGFloat = 0

        for i in 0..<imageCount{

            x = CGFloat(i) * CGFloat(contentWidth)

            let imageView:UIImageView = UIImageView(frame: CGRect(x: x, y: 0, width: self.bounds.width, height: self.bounds.height))
            imageView.backgroundColor = generateRandomColor()
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            
            DispatchQueue.main.async {
                parserVM.loadImage(urlString: APIImageUrl + imageList[i].ImagePath, imageView: imageView)
            }
            
            imageScrollView.addSubview(imageView)

           
        }

        imageScrollView.contentSize = CGSize(width: scrollTotawidth, height: height)
        
        parserVM.bannerImageCancellable.dispose()
        
        
    }
    
    func start(count:Int){
        buildTimerIfNeeded(count: count)
      
            
        timer?.resume()
            
        
        
    }
    
    func stop(){
        timer?.cancel()
        timer = nil
        
        
    }
    
    private func buildTimerIfNeeded(count:Int){
        guard timer == nil else {
            return
        }
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: .seconds(6), leeway: .seconds(2))
        timer?.setEventHandler(handler: { [weak self] in
           
            DispatchQueue.global(qos: .background).async{
                self?.showNext(count:count)
            }
                
                
         
        })
    }
    
    private func showNext(count:Int){
        
        DispatchQueue.main.async() {
        
        let totalPossibleOffset = CGFloat(count-1) * self.bounds.width
        
            if self.offSet == totalPossibleOffset{
            self.offSet = 0
            self.currentPage = 0
        }else{
            self.offSet += self.bounds.width
            //(offSet)
            let page =   self.offSet/self.bounds.width
            self.currentPage = Int(page)
            
            //print("offset:\(offSet)")
        }
        
        
        
        
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.Initialize_PagController(currentPage: self.currentPage, totalPage: count)
                    self.imageScrollView.contentOffset.x = CGFloat(self.offSet)
                }, completion: nil)
            }
        
        
        
    }
    
    func Initialize_PagController(currentPage:Int,totalPage:Int)  {
        pageControll.numberOfPages = totalPage
        pageControll.currentPage = currentPage
        pageControll.currentPageIndicatorTintColor = AppColor.Shared.teal_200
        pageControll.pageIndicatorTintColor = AppColor.Shared.colorPrimaryExtraDark
    }
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
            
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
            
        return randomColor
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("offset:\(scrollView.contentOffset.x)")
        offSet = scrollView.contentOffset.x
        currentPage = Int(scrollView.contentOffset.x/scrollView.frame.width)
        self.Initialize_PagController(currentPage: self.currentPage, totalPage: count)
    }
}

class CompanyLogImageView:UIImageView{
    
    override func awakeFromNib() {
        tintColorChange()
    }
    
    func tintColorChange(){
        
        self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = AppColor.Shared.colorWhite
        
    }
}

class CompanyLogBGView:UIView{
    
    override func awakeFromNib() {
        setViewAttribute()
    }
    
    func setViewAttribute(){
        self.setCornerRadius(size: 8)
      
        self.setBorder(width: 0.6, borderColor: AppColor.Shared.companyLogBorder)
    }
}



class CompanyLogLabel:UILabel{
    
    
    
    override func awakeFromNib() {
        fontAttributeProperty()
    }
    
    func fontAttributeProperty(){
        self.numberOfLines = 0
        self.font = AppFonts.Shared.Medium.withSize(15)
        //self.adjustsFontSizeToFitWidth = true
        self.textColor = AppColor.Shared.companyLog
    }
}


extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()

        return newImage
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func getFileSizeInfo(allowedUnits: ByteCountFormatter.Units = .useMB,
                           countStyle: ByteCountFormatter.CountStyle = .memory,
                           compressionQuality: CGFloat = 1.0) -> String? {
          
          let formatter = ByteCountFormatter()
          formatter.allowedUnits = allowedUnits
          formatter.countStyle = countStyle
          return getSizeInfo(formatter: formatter, compressionQuality: compressionQuality)
      }

      func getSizeInfo(formatter: ByteCountFormatter, compressionQuality: CGFloat = 1.0) -> String? {
          guard let imageData = jpegData(compressionQuality: compressionQuality) else { return nil }
          return formatter.string(fromByteCount: Int64(imageData.count))
      }
}



//class GenericTableviewController<T,Cell:UITableViewCell>:UIViewController{
//
//    var items:[T] = []{
//        didSet{
//            tableView.reloadData()
//        }
//    }
//    var configure: (Cell,T) -> Void
//    var selectHandler : (T) -> Void
//
//    init(items:[T],configure:@escaping (Cell,T) -> Void,selectHandler:@escaping (T) -> Void) {
//        self.items = items
//        self.configure = configure
//        self.selectHandler = selectHandler
//        super.init(style: UITableView.Style.plain)
//        self.tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//      }
//      //2
//      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
//        let item = items[indexPath.row]
//        configure(cell, item)
//        return cell
//      }
//      //3
//      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let item = items[indexPath.row]
//        selectHandler(item)
//        self.dismiss(animated: true)
//      }
//
//}

protocol HasValue {
    var value: String { get }
}

struct Person : HasValue{
  
  let name: String
    
 var value: String { return name }
  
  static var stubPerson: [Person] {
    return [
      Person(name: "Mark Hamill"),
      Person(name: "Harrison Ford"),
      Person(name: "Carrie Fisher"),
      Person(name: "Hayden Christensen"),
      Person(name: "Ewan McGregor"),
      Person(name: "Natalie Portman"),
      Person(name: "Liam Neeson")
   ]
  }
}
struct Film {
  let title: String
  let releaseYear: Int
  static var stubFilms: [Film] {
    return [
      Film(title: "Star Wars: A New Hope", releaseYear: 1978),
      Film(title: "Star Wars: Empire Strikes Back", releaseYear: 1982),
      Film(title: "Star Wars: Return of the Jedi", releaseYear:  1984),
      Film(title: "Star Wars: The Phantom Menace", releaseYear: 1999),
      Film(title: "Star Wars: Clone Wars", releaseYear: 2003),
      Film(title: "Star Wars: Revenge of the Sith", releaseYear: 2005)]
  }
}


//class DashboardMenuCellView:UIView{
//
//    var needNotificationText : Bool = false
//
//    lazy var cellStackView:UIStackView = {
//        let stackview = UIStackView(arrangedSubviews: [imageCustomView,menuLabel])
//        stackview.axis = .vertical
//        stackview.spacing = 2
//        //stackview.distribution = .fill
//       // stackview.alignment = .center
//        stackview.backgroundColor = UIColor.green
//        //stackview.translatesAutoresizingMaskIntoConstraints = false
//        return stackview
//    }()
//
//    lazy var imageCustomView:UIView = {
//        let view = UIView()
//
//
//
//        return view
//    }()
//
//    lazy var cellImageView:UIImageView = {
//        let view = UIImageView()
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
//    lazy var cellTopLabel:UILabel = {
//        let view = UILabel()
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
//
//
//
//
//    lazy var menuLabel : UILabel = {
//
//        let label = UILabel()
//        label.text = "fjsdgsjjjggggg"
//        label.numberOfLines = 0
//        return label
//
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//
//    func commonInit(){
//
//        self.addSubview(cellStackView)
//        self.cellStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        var cellSVConstraint = [NSLayoutConstraint]()
//
//        cellSVConstraint.append(self.cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5))
//
//        cellSVConstraint.append(self.cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5))
//
//
//        cellSVConstraint.append(self.cellStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5))
//
//        cellSVConstraint.append(self.cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5))
//
//        NSLayoutConstraint.activate(cellSVConstraint)
//
//
//        self.imageCustomView.addSubview(cellImageView)
//
//        var cellImgViewConstaint = [NSLayoutConstraint]()
//
//        cellImgViewConstaint.append(self.cellImageView.centerXAnchor.constraint(equalTo: self.imageCustomView.centerXAnchor, constant: 0))
//
//        cellImgViewConstaint.append(self.cellImageView.centerYAnchor.constraint(equalTo: self.imageCustomView.centerYAnchor, constant: 0))
//
////        cellImgViewConstaint.append(self.cellImageView.heightAnchor.constraint(equalToConstant: 30))
////        cellImgViewConstaint.append(self.cellImageView.widthAnchor.constraint(equalToConstant: 30))
//
//       // NSLayoutConstraint.activate(cellImgViewConstaint)
//
//
//
//    }
//
//
//
//}
