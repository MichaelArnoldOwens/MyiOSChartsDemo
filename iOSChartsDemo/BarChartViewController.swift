//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {
    var months: [String]!
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var savedToCameraRollLabel: UILabel!
    

    @IBAction func saveChart(sender: AnyObject) {
        //disable button
        savedToCameraRollLabel.enabled = false
        
        //saves chart to camera roll
//        barChartView.saveToCameraRoll()
        
        //show text
        savedToCameraRollLabel.hidden = false
        
        //fade out text and resets button state
        UIView.animateWithDuration(2.0, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.savedToCameraRollLabel.alpha = 0
            }, completion: { (finished: Bool) -> Void in
                self.savedToCameraRollLabel.hidden = true
                self.savedToCameraRollLabel.alpha = 1
                self.savedToCameraRollLabel.enabled = true
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        barChartView.delegate = self
        //create demo data
        barChartView.noDataText = "You need to provide data for the chart."
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        setChart(months, values: unitsSold)
    }
    
    //gets called when we select a bar
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value) in \(months[entry.xIndex])")
    }
    
    //setup the chart
    func setChart(dataPoints: [String], values: [Double]) {
        //default message if there's no data
        barChartView.noDataText = "You need to provide data for the chart."
        //sets description (default is 'description')
        barChartView.descriptionText = ""

        //create an array of BarChartDataEntry Objects
        var dataEntries: [BarChartDataEntry] = []
        
        //load the array with values
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        //labels the legend and creates a data set
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        
        //links x to y values
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        
        //set the BarChartView with our generated chart data
        barChartView.data = chartData
        
        //change colors of bars
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        //changes the x-access label's position
        barChartView.xAxis.labelPosition = .Bottom
        
        //animates the bars with a bounce
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseInBounce)
        
        //limit line
        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        barChartView.rightAxis.addLimitLine(ll)
    }

}

