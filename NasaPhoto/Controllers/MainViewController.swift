//
//  MainVCViewController.swift
//  NasaPhoto
//
//  Created by Sona on 13.03.24.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var currentCameraLabel: UILabel!
    @IBOutlet weak var currentRoverLabel: UILabel!
    
    var roverInfo: [Info] = []
    
    var page: Int = 0
    var isPagination:Bool = true
    
    var viewModel: RoversViewModel = RoversViewModel()
    var subscriber = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        bindingViewModel()
        viewModel.getRoversList(page: page)
    }
    
    private func configUI(){
        dataTableView.register(UINib(nibName: "MainViewCell", bundle: nil), forCellReuseIdentifier: MainViewCell.id)
        dataTableView.separatorStyle = .none
        
    }
    
    private func updateView(){
        todayLabel.text = FilterManager.shared.currentFilter.date.convertDateFormat()
        currentCameraLabel.text = FilterManager.shared.currentFilter.camera
        currentRoverLabel.text = FilterManager.shared.currentFilter.rover
        if FilterManager.shared.currentFilter.rover == "All" {
            roverInfo = FilterManager.shared.roversList
        }else{
            roverInfo = FilterManager.shared.roversList.filter {
                $0.rover.name == FilterManager.shared.currentFilter.rover
            }
        }
        dataTableView.reloadData()
    }
    
    private func bindingViewModel(){
        self.viewModel.$roversList
            .compactMap({ $0 })
            .sink { [weak self] data in
                let currentArray = (self?.roverInfo ?? []) + data
                self?.roverInfo = currentArray.reduce(into: [Info]()) { ( result, info) in
                    if !result.contains(where: { $0.id == info.id }) {
                        result.append(info)
                    }
                }
                DispatchQueue.main.async {
                    self?.dataTableView.reloadData()
                }
                self?.isPagination = true
                FilterManager.shared.roversList = data
            }.store(in: &subscriber)
        
        
        self.viewModel.$roversFiltersList
            .compactMap({ $0 })
            .sink { [weak self] data in
                self?.roverInfo = data
                FilterManager.shared.roversList = data
                DispatchQueue.main.async {
                    self?.updateView()
                }
            }.store(in: &subscriber)
    }
    
    
    //MARK: -Action
    
    @IBAction func openCalendar(_ sender: UIButton){
        let vc: DateFilterController = DateFilterController()
        vc.modalPresentationStyle = .overFullScreen
        vc.viewModel = viewModel
        self.present(vc, animated: true)
    }
    
    @IBAction func filterByCamera(_ sender: UIButton){
        let vc: FiltersPickerController = FiltersPickerController()
        vc.modalPresentationStyle = .overFullScreen
        vc.ft = .camera
        vc.viewModel = viewModel
        self.present(vc, animated: true)
    }
    
    @IBAction func filterByRover(_ sender: UIButton){
        let vc: FiltersPickerController = FiltersPickerController()
        vc.modalPresentationStyle = .overFullScreen
        vc.ft = .rover
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func showHistoryAction(_ sender: UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func saveAction(_ sender: UIButton){
        let alert = UIAlertController(title: "Save Filters", message: "The current filters and the date you have chosen can be saved to the filter history.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: {[weak self] _ in
            self?.saveFilter()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveFilter(){
        CoreDataManager.shared.saveFilters(data: FilterManager.shared.currentFilter)
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roverInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.id, for: indexPath) as! MainViewCell
        cell.selectionStyle = .none
        cell.configUI(info: roverInfo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FullScreenImageViewController") as! FullScreenImageViewController
        vc.imgString = roverInfo[indexPath.row].imgSrc
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        
        if pos > dataTableView.contentSize.height - 50 - scrollView.frame.size.height && isPagination{
            isPagination = false
            if !FilterManager.shared.isFilterOn {
                page += 1
                viewModel.getRoversList(page: page)
            }else{
                viewModel.getFiltersRovers(type: FilterManager.shared.requestType) { _ in}
            }
        }
    }
}

extension MainViewController: FilterByRover{
    func filterRovers() {
        if FilterManager.shared.currentFilter.rover == "All" {
            roverInfo = FilterManager.shared.roversList
        }else{
            roverInfo = FilterManager.shared.roversList.filter {
                $0.rover.name == FilterManager.shared.currentFilter.rover
            }
        }
        updateView()
    }
    
    
}
