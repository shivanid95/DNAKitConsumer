//
//  PrimaryViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 22/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit


var items = [
    "Foundation", "Atoms", "Molecules", "Organisms", "Pages"
]

var data = [
    "Foundation" : [
        "Typography",
        "Color Scheme",
        "Shadows",
        "Attributed String",
        "Image Assets",
        
    ],
    
    "Atoms": [
        "Buttons",
        "Labels",
        "TextView",
        "TextFeild",
        "State View",
        "Image View"
    ],
    "Molecules": [
        "Tooltip",
        "Snackbar",
        "Alerts",
        "Pickers",
        "Toast",
        
    ],
    "Organisms": [
        "Todo"
    ],
    "Pages": [
        "Web View COntroller",
        "Image view Controller"
    ]
    
    
]

class PrimaryViewController: UIViewController {
    
    private enum Constants {
        static let collectionViewCellReuseId = "collectionViewCellReuseId"
        static let collectionViewHeaderReuseId = "collectionViewHeaderReuseId"
        static let tableViewCellReuseId = "tableViewCellReuseId"
    }
    
    var model: PrimaryModelProtocol!
    
    var coordinatorDelegate: PrimaryCoordinatorDelegate?
    
    //MARK: - UI Components
    
    fileprivate let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.itemSize = .init(width: 120, height: 42)
        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.register(DNACapsuleCVCell.self, forCellWithReuseIdentifier: Constants.collectionViewCellReuseId)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.allowsSelection = true
        cv.isMultipleTouchEnabled = false
        cv.contentInset = .init(top: 16, left: 0, bottom: 16, right: 16)
        cv.bounces = true
        
        return cv
    }()
    
    fileprivate lazy var tableView: DNAContentSizedTableView = {
        let tv = DNAContentSizedTableView()
        tv.register(ComponentTVCell.self, forCellReuseIdentifier: Constants.tableViewCellReuseId)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.layer.cornerRadius = 8
        tv.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        tv.allowsSelection = true
        return tv
    }()
    
    var selectedElementIndex: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  .white
        self.navigationItem.title = "Pattern Library"
        
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        view.backgroundColor = Color.backgroundLight
        setup()
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    //MARK: - Init
    
    init(model: PrimaryModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    func setup() {
        view.stack(collectionView.withHeight(60), tableView, spacing: 16, alignment: .fill, distribution: .fill).withMargins(.init(top: view.safeAreaInsets.top + 10, left: 16, bottom: 48, right: 16))
        
    }
    
    
}


extension PrimaryViewController: UICollectionViewDelegate {    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedElementIndex = indexPath.item
    }
}

extension PrimaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfDesignComponents()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellReuseId, for: indexPath) as? DNACapsuleCVCell else { fatalError("Collection view cell not loaded") }
        cell.title = model.designElementAt(index: indexPath.item)?.title
        return cell
    }
    
    
}


extension PrimaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfTableViewItems(for: selectedElementIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellReuseId, for: indexPath) as? ComponentTVCell else {
            fatalError()
        }
        cell.title = model.tableViewItem(for: selectedElementIndex, index: indexPath.item).title
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension PrimaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let screenType = model.screenAt(segment: selectedElementIndex, index: indexPath.item) else { return }
        
        coordinatorDelegate?.show(screenType)
    }
}
