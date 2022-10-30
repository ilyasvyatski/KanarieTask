//
//  ViewController.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/26/22.
//

import UIKit
import Charts

fileprivate func makeRepository() -> KanarieEnergyRepository {
    KanarieEnergyRemoteRepository(httpClient: URLSessionHTTPClient(), api: .dev)
}

fileprivate func makeViewModel(
    repository: KanarieEnergyRepository, onSuccess: @escaping (_ factValue: KanarieEnergies) -> Void,
    onError: @escaping (_ errorMessage: String) -> Void) -> KanarieEnergyViewModel {
    KanarieEnergyViewModel(repository: repository, onSuccess: onSuccess, onError: onError)
}

class ViewController: UIViewController {
    
    private var viewModel: KanarieEnergyViewModel!
    
    @IBOutlet var customSegmentedControl: CustomSegmentedControl!
    
    @IBOutlet weak var barEnergyChart: BarChartView!
    
    @IBOutlet weak var totalEnergy: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customSegmentedControl.items = ["Day", "Week", "Month", "Year"]
        customSegmentedControl.font = UIFont(name: "Avenir-Black", size: 12)
        customSegmentedControl.borderColor = UIColor(white: 1.0, alpha: 1)
        customSegmentedControl.selectedIndex = 0
        customSegmentedControl.padding = 4
        
        viewModel.fetchKanarieEnergyDay()
    }

    @IBAction func segmentAction(_ sender: CustomSegmentedControl) {
        switch sender.selectedIndex {
        case 0:
            viewModel.fetchKanarieEnergyDay()
        case 1:
            viewModel.fetchKanarieEnergyWeek()
        case 2:
            viewModel.fetchKanarieEnergyMonth()
        case 3:
            viewModel.fetchKanarieEnergyYear()
        default:
            break
        }
    }
    
    // MARK: - Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.viewModel = makeViewModel(
        repository: makeRepository(),
        onSuccess: { [weak self] in self?.onSuccess(factMessage: $0) },
        onError: { [weak self] in self?.onError(errorMessage: $0) }
      )
    }
    
    func onSuccess(factMessage: KanarieEnergies) {
        //print(Self.self, #function, String(factMessage[0].energyDeltaKwh))
        
        var barChartEntries = [BarChartDataEntry]()
        
        var totalEnergyCount = 0.0
        
        for item in factMessage {
            barChartEntries.append(BarChartDataEntry(x: Double(item.id), y: Double(item.energyDeltaKwh)))
            totalEnergyCount += item.energyDeltaKwh
        }
        
        totalEnergy.text = String(round(1000 * totalEnergyCount) / 1000)
        
        let barSet = BarChartDataSet(entries: barChartEntries)
        let data = BarChartData(dataSet: barSet)
        barEnergyChart.data = data
    }
    
    func onError(errorMessage: String) {
      print(Self.self, #function, errorMessage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

