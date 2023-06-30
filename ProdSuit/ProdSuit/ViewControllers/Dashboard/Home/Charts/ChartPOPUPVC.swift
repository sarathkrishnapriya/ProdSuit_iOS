//
//  ChartPOPUPVC.swift
//  ProdSuit
//
//  Created by MacBook on 28/03/23.
//

import UIKit
import Charts

class ChartPOPUPVC: UIViewController {
    
    @IBOutlet weak var chartDescriptionLabel: UILabel!
    @IBOutlet weak var chartTitleLabel: UILabel!
    lazy var leadsInfoList : [LeadDashBoardDetailsModel] = []
    
    var barchartViewConstraints = [NSLayoutConstraint]()
    
    lazy var leadStageView: BarChartView = {
        let barchartView = BarChartView()
        barchartView.translatesAutoresizingMaskIntoConstraints = false
        return barchartView
    }()
    
    var piechartViewConstraints = [NSLayoutConstraint]()
    
    lazy var leadsAndStatusView: PieChartView = {
        let barchartView = PieChartView()
        barchartView.translatesAutoresizingMaskIntoConstraints = false
        return barchartView
    }()
    
    var chartType :String = ""

    var chartColors : [UIColor] = []
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var transparentView: UIView!
    fileprivate func barchartConstraintAdd() {
        
        self.chartView.addSubview(leadStageView)
        self.chartTitleLabel.text = "LEADS STAGES"
        self.chartDescriptionLabel.text = "IN COUNT"
        //leadStageView.backgroundColor = AppColor.Shared.purple_500
        barchartViewConstraints.append(self.leadStageView.topAnchor.constraint(equalTo: self.chartView.topAnchor, constant: 10))
        barchartViewConstraints.append(self.leadStageView.leadingAnchor.constraint(equalTo: self.chartView.leadingAnchor, constant: 10))
        barchartViewConstraints.append(self.leadStageView.trailingAnchor.constraint(equalTo: self.chartView.trailingAnchor, constant: -10))
        barchartViewConstraints.append(self.leadStageView.bottomAnchor.constraint(equalTo: self.chartView.bottomAnchor, constant: -10))
        NSLayoutConstraint.activate(barchartViewConstraints)
    }
    
    fileprivate func removeBarchartView() {
        leadStageView.removeFromSuperview()
        NSLayoutConstraint.deactivate(barchartViewConstraints)
    }
    
    fileprivate func removePiechartView(chart:PieChartView) {
        chart.removeFromSuperview()
        NSLayoutConstraint.deactivate(piechartViewConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    fileprivate func piechartConstraintsAdd(_ chartTitle:String) {
        self.chartView.addSubview(leadsAndStatusView)
        self.chartTitleLabel.text = chartTitle
        self.chartDescriptionLabel.text = "IN PERCENTAGE"
        //leadsAndStatusView.backgroundColor = AppColor.Shared.color_warning
        piechartViewConstraints.append(self.leadsAndStatusView.topAnchor.constraint(equalTo: self.chartView.topAnchor, constant: 10))
        piechartViewConstraints.append(self.leadsAndStatusView.leadingAnchor.constraint(equalTo: self.chartView.leadingAnchor, constant: 10))
        piechartViewConstraints.append(self.leadsAndStatusView.trailingAnchor.constraint(equalTo: self.chartView.trailingAnchor, constant: -10))
        piechartViewConstraints.append(self.leadsAndStatusView.bottomAnchor.constraint(equalTo: self.chartView.bottomAnchor, constant: -10))
        NSLayoutConstraint.activate(piechartViewConstraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if chartType == "leadStages"{
            
            
            removePiechartView(chart: leadsAndStatusView)
            barchartConstraintAdd()
            customBarCharts(listInfo: leadsInfoList, barchartView:leadStageView)
            
            
        }else{
            
            removeBarchartView()
            let chartTitle = chartType == "leads" ? "LEADS" : "LEAD STATUS"
            piechartConstraintsAdd(chartTitle)
            customizeChart(listInfo: leadsInfoList, piechartView: leadsAndStatusView)
            
        }
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
        chartDataSet.colors = chartColors
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
        
        
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
    
        
        
        
        l.setCustom(entries: legendEntries)
       
        l.font = AppFonts.Shared.Regular.withSize(11)
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 0
        l.yEntrySpace = 2
        l.yOffset = 0
        
       
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
        
         pieChartDataSet.colors = chartColors
         // 3. Set ChartData
         let pieChartData = PieChartData(dataSet: pieChartDataSet)
         
        //pieChartDataSet.sliceSpace = 0.5
     
        pieChartDataSet.xValuePosition = .outsideSlice
        pieChartDataSet.entryLabelColor = AppColor.Shared.colorPrimary
        var valueColor : [UIColor] = []
        valueColor = pieChartDataSet.colors.map{ $0.contastingTextColour }
        pieChartDataSet.valueColors = valueColor
        
        piechartView.transparentCircleRadiusPercent = 0.4
        
        

        pieChartData.setValueFont(AppFonts.Shared.Medium.withSize(13))
        
         // 4. Assign it to the chart’s data
          
        
        let l = piechartView.legend
        
                l.horizontalAlignment = .center
                l.verticalAlignment = .bottom
    
//                l.setCustom(entries: [LegendEntry(label: "Shirts (44.55%)"),LegendEntry(label: "Jeans (55.45%)")])
        
                l.orientation = .vertical
                l.drawInside = false
    
                l.xEntrySpace = 0
                l.yEntrySpace = 2
                l.yOffset = -9
              
        
        
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
        
        piechartView.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: ChartEasingOption.easeOutCirc)
        
         
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeBarchartView()
        removePiechartView(chart: leadsAndStatusView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == transparentView{
            self.dismiss(animated: true)
        }
    }
}
