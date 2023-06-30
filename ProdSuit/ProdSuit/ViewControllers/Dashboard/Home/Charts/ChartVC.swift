//
//  ChartVC.swift
//  ProdSuit
//
//  Created by MacBook on 22/03/23.
//

import UIKit
import Charts



class ChartVC: UIViewController {

    weak var chartVCViewModel:ChartVCViewModel!
    
    @IBOutlet weak var leadStagesView: BarChartView!
    @IBOutlet weak var leadStatusView: PieChartView!
    @IBOutlet weak var leadsView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.chartVCViewModel = ChartVCViewModel(controller: self)
        

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          
//        let players = ["Shirts","Jeans","T-shirts"]
//        let goals = [35.55,55.45,9]
        self.chartVCViewModel = ChartVCViewModel(controller: self)        //customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func stringFromNumberformate(number:Double) -> String{
        let formate = NumberFormatter()
        formate.numberStyle = .percent
       
        formate.maximumFractionDigits = 2
        formate.multiplier = 1
        formate.zeroSymbol = ""
        formate.percentSymbol = "%"
        let number = NSNumber(value: number)
        let formateValue = formate.string(from: number)
        return formateValue!
    }
    
    
    func customBarCharts(listInfo:[LeadDashBoardDetailsModel],barchartView:BarChartView){
        var dataEntries:[ChartDataEntry] = []
        var dataPoints : [String] = []
        
        
        for i in 0..<listInfo.count{
            
            dataPoints.append(listInfo[i].Fileds)
//            let dataEntry = BarChartDataEntry(x: Double(i), y: listInfo[i].Count)
            let dataEntry = BarChartDataEntry(x: Double(i), y: listInfo[i].Count, data: listInfo[i].Fileds as AnyObject)
            dataEntries.append(dataEntry)
            
        }
        
        
        
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.drawValuesEnabled = true
        chartDataSet.colors = colorsOfCharts(numbersOfColor: listInfo.count)
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFont(AppFonts.Shared.Medium.withSize(13))
        chartData.barWidth = 0.8
        
        var legendEntries : [LegendEntry] = []
        
        for i in 0..<dataPoints.count{
            let item = LegendEntry(label: dataPoints[i])
            item.form = .square
            item.formColor = chartDataSet.colors[i]
            
            legendEntries.append(item)
        }
        
        let l = barchartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .center
        l.orientation = .vertical
        l.setCustom(entries: legendEntries)
       
        l.font = AppFonts.Shared.Regular.withSize(11)
        l.xEntrySpace = 5
        l.yEntrySpace = 2
        l.yOffset = 0
        
        //barchartView.delegate = self
        barchartView.drawBarShadowEnabled = false
        barchartView.drawValueAboveBarEnabled = true
        
        let formatter = BarChartFormatter()
            formatter.setValues(values: dataPoints)
            let xaxis:XAxis = XAxis()
        
            xaxis.valueFormatter = formatter
            barchartView.highlighter = .none
            barchartView.setScaleEnabled(false)
            barchartView.xAxis.drawLabelsEnabled = false
            barchartView.rightAxis.drawGridLinesEnabled = false
            barchartView.leftAxis.drawGridLinesEnabled = false
            barchartView.xAxis.drawGridLinesEnabled = false
            barchartView.xAxis.valueFormatter = xaxis.valueFormatter
            barchartView.rightAxis.enabled = false
            barchartView.xAxis.drawAxisLineEnabled = false
        
            barchartView.animate(yAxisDuration: 0.75)
        
        let barChartTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(chartDidClick(_:)))
           
           barChartTapRecognizer.numberOfTapsRequired = 1
           barchartView.addGestureRecognizer(barChartTapRecognizer)
        
          barchartView.data = chartData
          barchartView.notifyDataSetChanged()
        
        
        
        
    }
    
    
    func customizeChart(listInfo:[LeadDashBoardDetailsModel],piechartView:PieChartView) {
        // 1. Set ChartDataEntry
         var dataEntries: [ChartDataEntry] = []
         for i in 0..<listInfo.count {
             let valueString = stringFromNumberformate(number: listInfo[i].Count)
             let legendText = listInfo[i].Count == 0 ? listInfo[i].Fileds : listInfo[i].Fileds + " (\(valueString))"
             let dataEntry = PieChartDataEntry(value: listInfo[i].Count, label: legendText, data: " (\(listInfo[i].Count))" as AnyObject)
            
             
           dataEntries.append(dataEntry)
         }
         // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        
         pieChartDataSet.colors = colorsOfCharts(numbersOfColor: listInfo.count)
         // 3. Set ChartData
         let pieChartData = PieChartData(dataSet: pieChartDataSet)
         
        //pieChartDataSet.sliceSpace = 0.5
     
        pieChartDataSet.xValuePosition = .outsideSlice
        pieChartDataSet.entryLabelColor = AppColor.Shared.colorPrimary
        var valueColor : [UIColor] = []
        valueColor = pieChartDataSet.colors.map{ $0.contastingTextColour }
        pieChartDataSet.valueColors = valueColor
        
        piechartView.transparentCircleRadiusPercent = 0.4
        
        //piechartView.noDataText = listInfo.count == 0 ? "No data available" : "Loading..."

        pieChartData.setValueFont(AppFonts.Shared.Medium.withSize(13))
        
         // 4. Assign it to the chart’s data
          //piechartView.delegate = self
        
        let l = piechartView.legend
        
                l.horizontalAlignment = .center
                l.verticalAlignment = .bottom
    
//                l.setCustom(entries: [LegendEntry(label: "Shirts (44.55%)"),LegendEntry(label: "Jeans (55.45%)")])
        
                l.orientation = .vertical
                l.drawInside = false
                l.xEntrySpace = 0
                l.yEntrySpace = 2
                l.yOffset = 0
              
        
    
        piechartView.highlightPerTapEnabled = false
        piechartView.usePercentValuesEnabled = true
        piechartView.rotationEnabled = false
        piechartView.holeRadiusPercent = 0.4
        piechartView.legend.font = AppFonts.Shared.Regular.withSize(11)
        piechartView.drawSlicesUnderHoleEnabled = false
        piechartView.drawEntryLabelsEnabled = false
        //self.leadsView.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
        
        piechartView.setExtraOffsets(left: -10, top: -10, right: -10, bottom: -10)
       
         
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
       
        pFormatter.maximumFractionDigits = 2
        pFormatter.multiplier = 1
        pFormatter.zeroSymbol = ""
        pFormatter.percentSymbol = "%"
        piechartView.data = pieChartData
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        piechartView.notifyDataSetChanged()
        
        if piechartView == leadsView{
            
            let leadsTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(leadsChartDidClick(_:)))
            leadsTapRecognizer.numberOfTapsRequired = 1
            piechartView.addGestureRecognizer(leadsTapRecognizer)
            
        }else{
            
            let leadsStatusTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(leadStatusChartDidClick(_:)))
            leadsStatusTapRecognizer.numberOfTapsRequired = 1
            piechartView.addGestureRecognizer(leadsStatusTapRecognizer)
            
        }
        
        piechartView.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: ChartEasingOption.easeOutCirc)
        
         
    }
    
    
    @objc func leadsChartDidClick(_ chartView:ChartViewBase){
        
        if self.navigationController?.presentedViewController?.isKind(of: ChartPOPUPVC.self) == nil{
        let chartDetailVC = AppVC.Shared.ChartPopUpPage
        chartDetailVC.modalTransitionStyle = .crossDissolve
        chartDetailVC.modalPresentationStyle = .overCurrentContext
        chartDetailVC.leadsInfoList = chartVCViewModel.leadsList
        chartDetailVC.chartType = "leads"
        chartDetailVC.chartColors = leadsView.data!.colors
        self.present(chartDetailVC, animated: true)
        }
        
     }
    
    @objc func leadStatusChartDidClick(_ chartView:ChartViewBase){
        if self.navigationController?.presentedViewController?.isKind(of: ChartPOPUPVC.self) == nil{
        let chartDetailVC = AppVC.Shared.ChartPopUpPage
        chartDetailVC.modalTransitionStyle = .crossDissolve
        chartDetailVC.modalPresentationStyle = .overCurrentContext
        chartDetailVC.leadsInfoList = chartVCViewModel.leadsStatusList
        chartDetailVC.chartType = "leadStatus"
        chartDetailVC.chartColors = leadStatusView.data!.colors
        self.present(chartDetailVC, animated: true)
        }
     }

    
    
   @objc func chartDidClick(_ chartView:ChartViewBase){
       if self.navigationController?.presentedViewController?.isKind(of: ChartPOPUPVC.self) == nil{
       let chartDetailVC = AppVC.Shared.ChartPopUpPage
       chartDetailVC.modalTransitionStyle = .crossDissolve
       chartDetailVC.modalPresentationStyle = .overCurrentContext
       chartDetailVC.leadsInfoList = chartVCViewModel.leadsStageList
       chartDetailVC.chartType = "leadStages"
       chartDetailVC.chartColors = leadStagesView.barData!.colors
       self.present(chartDetailVC, animated: true)
       }
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
    

    @IBAction func backButtonAction(_ sender: BackButtonCC) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.chartVCViewModel.leadsCancellable.dispose()
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

//extension ChartVC:ChartViewDelegate{
//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        print("selected:\(chartView.legend.entries)")
//
//
//
//    }
//}
