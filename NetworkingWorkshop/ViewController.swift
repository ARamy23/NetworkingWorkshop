//
//  ViewController.swift
//  NetworkingWorkshop
//
//  Created by ScaRiLiX on 10/12/18.
//  Copyright © 2018 ScaRiLiX. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    @IBOutlet weak var loopBackTableView: UITableView!
    
    let cellId = "cellId"
    
    var timelines = [Timeline]()
    {
        didSet
        {
            loopBackTableView.reloadData()
        }
    }
    
    let provider = MoyaProvider<TimelineService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loopBackTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        getTimelines()
        
    }
    
    func getTimelines()
    {
        provider.request(.getAll) { [weak self] (result) in
            switch result
            {
            case .success(let response):
                do
                {
                    let timelines = try JSONDecoder().decode([Timeline].self, from: response.data)
                    self?.timelines = timelines
                }
                catch let err
                {
                    print(err)
                }
            case .failure(let err):
                print(err)
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        let timeline = timelines[indexPath.row]
        let attributedText = NSMutableAttributedString(string: "date: \(String(describing: timeline.date ?? "No Date"))\n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "text: \(String(describing: timeline.text ?? "No text"))\n"))
        attributedText.append(NSAttributedString(string: "userId: \(String(describing: timeline.id ?? 0))\n"))
        cell.textLabel?.attributedText = attributedText
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
