//
//  ViewController.swift
//  NetworkingWorkshop
//
//  Created by ScaRiLiX on 10/12/18.
//  Copyright © 2018 ScaRiLiX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loopBackTableView: UITableView!
    
    let cellId = "cellId"
    
    var datasource = [Timeline]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loopBackTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        fetchTimeline()
    }
    
    fileprivate func fetchTimeline()
    {
        let urlString = "https://nodeswiftcairo.herokuapp.com/api/timelines"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, err) in
            if let err = err
            {
                print(err)
                return
            }
            guard let data = data else { return }
            do
            {
                let timelines = try JSONDecoder().decode([Timeline].self, from: data)
                self?.datasource = timelines
                
                DispatchQueue.main.async { self?.loopBackTableView.reloadData() }
            }
            catch let err
            {
                print(err)
            }
        }.resume()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        let timeline = datasource[indexPath.row]
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
