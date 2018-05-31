//
//  ViewController.swift
//  FilterExample
//
//  Created by Patrick Bellot on 5/29/18.
//  Copyright © 2018 Polestar Interactive LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	override var prefersStatusBarHidden: Bool { return true }

	let filterNames = ["CIPhotoEffectChrome", "CIPhotoEffectFade",
										 "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir",
										 "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer",
										 "CIVignette", "CIVignetteEffect", "CIUnsharpMask",
										 "CIComicEffect", "CIDepthOfField", "CIEdges",
										 "CISpotLight"]
	
	let containerView: UIView = {
		let containerView = UIView()
		return containerView
	}()
	
	let currentImageView: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "teagan.jpg")
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	lazy var filteredImageView: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "teagan.jpg")
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	lazy var scrollview: UIScrollView = {
		let scrollview = UIScrollView()
		scrollview.isPagingEnabled = true
		scrollview.backgroundColor = UIColor.clear
		scrollview.showsHorizontalScrollIndicator = false
		scrollview.showsVerticalScrollIndicator = false
		scrollview.contentMode = .scaleAspectFill
		scrollview.frame = view.frame
		return scrollview
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	fileprivate func setupUI() {
		
		view.add(containerView)
		containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
		
		containerView.add(currentImageView)
		currentImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
		
		containerView.add(filteredImageView)
		filteredImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
		
		view.add(scrollview)
		scrollview.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
	}
	
	func applyMask(_ maskRect: CGRect) {
		let maskLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addRect(maskRect)
		maskLayer.path = path
		filteredImageView.layer.mask = maskLayer
	}
	
} // end of class

















