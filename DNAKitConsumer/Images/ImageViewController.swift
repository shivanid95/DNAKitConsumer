//
//  ImageViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 28/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import UIKit
import DNAKit

class ImageViewController: UIViewController {
    
    private let imageStates = DNAImageViewState.allCases.map { (state) -> String in
        return "\(state)"
    }
    
    fileprivate lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: imageStates)
        segment.addTarget(self, action: #selector(segmentValueChanged(_:)) , for: .valueChanged)
        return segment
    }()
    
    
    fileprivate let imageView: DNAImageView = {
        let imgView = DNAImageView(source: DNAImageSource.urlString("https://sample-videos.com/img/Sample-jpg-image-500kb.jpg"))
        imgView.setImage(.urlString("https://www.elegantthemes.com/blog/wp-content/uploads/2016/03/500-internal-server-error-featured-image-1.png"), forState: .error)
        imgView.setImage(.urlString("https://image.shutterstock.com/image-vector/loading-icon-logo-isolated-on-260nw-1453631144.jpg"), forState: .empty)
        return imgView
    }()
    
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        imageView.state = DNAImageViewState(rawValue: sender.selectedSegmentIndex) ?? .normal
    }
    
    
     init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.appWhite
        title = "ImageView"
    }
    
    func setup() {
        view.stack(segmentControl, imageView.withSize(.init(width: 250, height: 250)), UIView(), spacing: 24, alignment: .center, distribution: .fill).withMargins(.allSides(16))
    }
}
