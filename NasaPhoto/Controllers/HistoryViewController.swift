//
//  HistoryViewController.swift
//  NasaPhoto
//
//  Created by Sona on 16.03.24.
//

import Foundation
import UIKit


class HistoryViewController: UIViewController {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var historyTableView: UITableView!
    
    
    var history: [FilterModel] {
        return CoreDataManager.shared.fetchLocalFilters()
    }
    
    var viewModel: RoversViewModel = RoversViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI(){
        emptyView.isHidden = !history.isEmpty
        dataView.isHidden = history.isEmpty
        
        historyTableView.register(UINib(nibName: "HistoryViewCell", bundle: nil), forCellReuseIdentifier: HistoryViewCell.id)
        historyTableView.separatorStyle = .none
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func filterByDate(currentFilter: FilterModel){
        FilterManager.shared.currentFilter = currentFilter
        
        if currentFilter.camera == "All"{
            FilterManager.shared.requestType = .filterByDate(0, currentFilter.date.convertToDate())
            viewModel.getFiltersRovers(type: .filterByDate(0, currentFilter.date.convertToDate()), completion: { finish in
                self.navigationController?.popViewController(animated: true)
            })
        }else{
            FilterManager.shared.requestType = .filterByCamera(0, currentFilter.date.convertToDate(), currentFilter.camera)
            viewModel.getFiltersRovers(type: .filterByCamera(0, currentFilter.date.convertToDate(), currentFilter.camera)){ finish in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}

extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryViewCell.id, for: indexPath) as! HistoryViewCell
        cell.selectionStyle = .none
        cell.configUI(info: history[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Menu Filter", message: "", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Use", style: .default , handler:{ (UIAlertAction)in
                self.filterByDate(currentFilter: self.history[indexPath.row])
            }))
            

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                
                CoreDataManager.shared.deleteFilter(with: self.history[indexPath.row].id)
                
                self.historyTableView.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            self.present(alert, animated: true)
    }
    
    
}

