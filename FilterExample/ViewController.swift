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
		scrollview.delegate = self
		scrollview.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
		scrollview.isPagingEnabled = true
		scrollview.showsHorizontalScrollIndicator = false
		scrollview.showsVerticalScrollIndicator = false
		scrollview.contentMode = .scaleAspectFill
		applyMask(CGRect(x: self.view.bounds.width - scrollview.contentOffset.x, y: scrollview.contentOffset.y, width: scrollview.contentSize.width, height: scrollview.contentSize.height))
		return scrollview
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		createFilters()
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
	
	
	fileprivate func createFilters() {
		var itemCount = 0
		
		for i in 0..<filterNames.count {
			itemCount = i
			
			filteredImageView.frame = CGRect(x: 0, y: 0, width: currentImageView.frame.size.width, height: currentImageView.frame.size.height)
			filteredImageView.tag = itemCount
			
			let context = CIContext(options: nil)
			let originalImage = CIImage(image: filteredImageView.image!)
			guard let filter = CIFilter(name: "\(filterNames[i])") else { return print("No filter can be found")}
			
			filter.setValue(originalImage, forKey: kCIInputImageKey)
			let filteredImageData = filter.value(forKey: kCIInputImageKey) as! CIImage
			let filteredImageRef = context.createCGImage(filteredImageData, from: filteredImageData.extent)
			filteredImageView.image = UIImage(cgImage: filteredImageRef!)
			scrollview.add(filteredImageView)
	  }
		
		scrollview.contentSize = CGSize(width: (filteredImageView.image?.size.width)! * CGFloat(itemCount), height: (filteredImageView.image?.size.height)!)
	}
		
	func applyMask(_ maskRect: CGRect) {
		let maskLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addRect(maskRect)
		maskLayer.path = path
		filteredImageView.layer.mask = maskLayer
	}
} // end of class

extension ViewController: UIScrollViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		applyMask(CGRect(x: self.view.bounds.width - scrollview.contentOffset.x, y: scrollview.contentOffset.y, width: scrollView.contentSize.width, height: scrollView.contentSize.height))
	}
}
















