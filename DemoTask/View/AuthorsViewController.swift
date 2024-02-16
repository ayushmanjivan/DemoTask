//
//  AuthorsViewController.swift
//  DemoTask
//
//  Created by MacMini-dev on 26/05/23.
//

import UIKit

class AuthorsViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var defaultOffSet: CGPoint?
    private var viewModel = AuthorViewModel() // view model variable
    private let refreshControl = UIRefreshControl() // refresh control
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

//MARK: - Extension of view controller
extension AuthorsViewController {
//MARK:- setup ui
    func configuration() {
        initViewModel()
        observeEvent()
        refreshControl.addTarget(self, action: #selector(initViewModel), for: .valueChanged)
        tblView.addSubview(refreshControl)
        tblView.separatorStyle = .singleLine
        tblView.reloadData()
    }
    
//MARK: - fetching the api response
    @objc func initViewModel() {
        viewModel.fetchAuthorsData()
    }
   
// MARK: - data binding method
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading:
                print("authors loading.....")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    if self.refreshControl.isRefreshing == true {
                        self.refreshControl.beginRefreshing()
                    } else {
                        print("Calling API")
                        self.refreshControl.endRefreshing()
                    }
                }
            case .stopLoading:
                print("stop loading.....")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    self.refreshControl.endRefreshing()
                }
            case .dataLoaded:
                print("authors data loaded.....")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    self.tblView.reloadData()
                }
            case .error(let error):
                print(error as Any)
            }
        }
    }
    
// MARK: - Alert pop up
    func showSimpleAlert(message: String?) {
        let alert = UIAlertController(title: "Check Mark clicked", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                self.tblView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Go",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                self.tblView.reloadData()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table view data source methods
extension AuthorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblView.dequeueReusableCell(withIdentifier: "AuthorsCell", for: indexPath) as? AuthorsCell {
            var authorModel = viewModel.authors[indexPath.row]
            cell.authorModel = authorModel
            cell.btnCheckUncheck.isEnabled = true
            cell.checkboxTappedCompletion = {
                authorModel.isSelected = !authorModel.isSelected
                if authorModel.isSelected {
                    cell.btnCheckUncheck.setImage(UIImage(named: "checkedBox"), for: .normal)
                    cell.btnCheckUncheck.isEnabled = true
                } else {
                    cell.btnCheckUncheck.setImage(UIImage(named: "uncheckBox"), for: .normal)
                    self.showSimpleAlert(message: authorModel.author)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
      
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
