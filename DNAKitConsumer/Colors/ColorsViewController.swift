//
//  ColorsViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 27/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit

class ColorsViewController: UIViewController {
    
    var model: ColorsModelProtocol
    
    private enum Constant {
        static let cellReuseId = "cellReuseId"
    }
    
    
    fileprivate lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellReuseId)
        tv.rowHeight = 48
        tv.allowsSelection = false
        tv.separatorStyle = .none
        return tv
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.appWhite
        self.title = "Color Scheme"
    }
    
    //MARK: - Initialize
    
    init(model: ColorsModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    
}


extension ColorsViewController: UITableViewDelegate {
    
}


extension ColorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfColors()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellReuseId, for: indexPath)
        let colorObject = model.colorObject(at: indexPath.item)
        cell.backgroundColor = colorObject.color
        cell.tintColor = colorObject.textTintColor
        cell.textLabel?.text = colorObject.displayName
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = colorObject.textTintColor
        return cell
    }
    
    
}
