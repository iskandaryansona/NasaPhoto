//
//  DateFilterController.swift
//  NasaPhoto
//
//  Created by Sona on 15.03.24.
//

import UIKit


class DateFilterController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var viewModel: RoversViewModel = RoversViewModel()
    
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configDatePicker()
    }
    
    //MARK: - Action
    
    @IBAction func doneAction(_ sender: UIButton){
        filterByDate()
    }
    
    @IBAction func closeAction(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    private func configDatePicker(){
        datePicker.datePickerMode = .date
        let currentDate = Date()
        datePicker.maximumDate = currentDate
        datePicker.timeZone = TimeZone.gmt
    }
    
    private func filterByDate(){
        let currentDate = datePicker.date
        
        FilterManager.shared.isFilterOn = true
        if  FilterManager.shared.currentFilter.camera == "All" {
            FilterManager.shared.requestType = .filterByDate(page, currentDate)
            viewModel.getFiltersRovers(type: .filterByDate(page, currentDate), completion: { finish in
                self.update()
            })
            
        }else{
            FilterManager.shared.requestType = .filterByCamera(page, currentDate, FilterManager.shared.currentFilter.camera)
            viewModel.getFiltersRovers(type: .filterByCamera(page, currentDate, FilterManager.shared.currentFilter.camera)){ finish in
                self.update()
            }
        }
    }
    
    private func update(){
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = outputDateFormatter.string(from: datePicker.date)
        FilterManager.shared.currentFilter.date = currentDate
        dismiss(animated: true)
    }
}
