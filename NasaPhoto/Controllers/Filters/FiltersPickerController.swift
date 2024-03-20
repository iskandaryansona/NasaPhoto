//
//  FiltersPickerController.swift
//  NasaPhoto
//
//  Created by Sona on 15.03.24.
//

import UIKit
import Combine

protocol FilterByRover : class {
    func filterRovers()
}

class FiltersPickerController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataPicker: UIPickerView!
    
    var ft: FilterEn = .camera
    
    var cameraData: [Camera] = []
    var roverData: [Rover] = []
    var currentInfo: String = "All"
    var page: Int = 0
    
    
    var viewModel: RoversViewModel = RoversViewModel()
    
    weak var delegate: FilterByRover?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    private func configUI(){
        titleLabel.text = ft == .camera ? "Camera" : "Rover"
        dataPicker.delegate = self
        dataPicker.dataSource = self
    }
    
    
    @IBAction func doneAction(_ sender: UIButton){
        
        let currentDate = FilterManager.shared.currentFilter.date.convertToDate()
        FilterManager.shared.isFilterOn = true
        switch ft {
        case .camera:
            FilterManager.shared.currentFilter.camera = currentInfo
            if currentInfo != "All" {
                FilterManager.shared.requestType = .filterByCamera(page, currentDate, currentInfo)
                viewModel.getFiltersRovers(type: .filterByCamera(page, currentDate, currentInfo)){ finish in
                    self.dismiss(animated: true)
                }
            }else{
                FilterManager.shared.requestType = .filterByDate(page, currentDate)
                viewModel.getFiltersRovers(type: .filterByDate(page, currentDate), completion: { finish in
                    self.dismiss(animated: true)
                })
            }
        case .rover:
            FilterManager.shared.currentFilter.rover = currentInfo
            delegate?.filterRovers()
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func closeAction(_ sender: UIButton){
        dismiss(animated: true)
    }
    
}

extension FiltersPickerController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch ft {
        case .camera:
            return LocalData.cameraName.values.count
        default:
            return LocalData.roverName.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch ft {
        case .camera:
            let cameraValues = LocalData.cameraName.keys.sorted().map { LocalData.cameraName[$0]! }
            return cameraValues[row]
        default:
            return LocalData.roverName[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var text: String = ""
        let isSelectedRow = (row == pickerView.selectedRow(inComponent: component))
        let color = isSelectedRow ? UIColor.black : AppColors.grayLabelColor
        let font = isSelectedRow ? UIFont().boldSfPro(size: 28): UIFont().regularSfPro(size: 22)
        
        switch ft {
        case .camera:
            let cameraValues = LocalData.cameraName.keys.sorted().map { LocalData.cameraName[$0]! }
            text = cameraValues[row]
        default:
            text =  LocalData.roverName[row]
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : color,
            .font : font
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerView.reloadAllComponents()
        
        switch ft {
        case .camera:
            let cameraValues = LocalData.cameraName.keys.sorted()
            currentInfo = cameraValues[row]
            FilterManager.shared.currentFilter.camera = currentInfo
        default:
            currentInfo = LocalData.roverName[row]
            FilterManager.shared.currentFilter.rover = currentInfo
        }
    }
}
