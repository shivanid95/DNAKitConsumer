//
//  TypographyViewController.swift
//  DNAKitConsumer
//
//  Created by Shivani on 23/01/20.
//  Copyright © 2020 designSystem. All rights reserved.
//

import DNAKit
import UIKit


class TypographyViewController: UIViewController {
    
    fileprivate let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    fileprivate let textAlignment: NSTextAlignment = .center
    
    fileprivate lazy var segmentController: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Product", "Blogs"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentDidChange), for: .valueChanged)
        //segment.setTitle("Product", forSegmentAt: 0)
        // segment.setTitle("Blog", forSegmentAt: 1)
        return segment
        
    }()
    
    var contentType: ContentType = .product
    {
        didSet {
            h1Label.type = .h1(contentType)
            h2Label.type = .h2(contentType)
            h3Label.type = .h3(contentType)
            bodyLarge.type = .body(.large(contentType))
            bodySmall.type = .body(.small(contentType))
            bodyRegular.type = .body(.regular(contentType))
            
        }
        
    }
    
    fileprivate lazy var h1Label: DNALabel = {
        let label = DNALabel(withType: Typography.h1(contentType), text: "Header 1 (h1)")
        return label
    }()
    
    fileprivate lazy var h2Label: DNALabel = {
        let label = DNALabel(withType: .h2(contentType), text: "Header 2 (h2)")
        return label
    }()
    
    fileprivate lazy var h3Label: DNALabel = {
        let label = DNALabel(withType: .h2(contentType), text: "Header 3 (h3)")
        return label
    }()
    
    
    fileprivate lazy var bodyLarge: DNALabel = {
        let label = DNALabel(withType: .body(.large(contentType)), text: "Body Large")
        return label
    }()
    
    fileprivate lazy var bodyRegular: DNALabel = {
        let label = DNALabel(withType: .body(.regular(contentType)), text: "Body Regular")
        return label
    }()
    
    fileprivate lazy var bodySmall: DNALabel = {
        let label = DNALabel(withType: .body(.small(contentType)), text: "Body Small")
        return label
    }()
    
    fileprivate lazy var caption: DNALabel = {
        let label = DNALabel(withType: .caption, text: "caption")
        label.textAlignment = textAlignment
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Typography"
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        scrollView.stack(segmentController.withWidth(view.bounds.width - 40),UIView(), h1Label, h2Label, h3Label, bodyLarge, bodyRegular, bodySmall, caption,
                         spacing: 16,
                         alignment: .fill,
                         distribution: .fill).withMargins(.allSides(16))
    }
    
    
    @objc func segmentDidChange() {
        contentType = segmentController.selectedSegmentIndex == 0 ? .product : .blog
        
    }
}

