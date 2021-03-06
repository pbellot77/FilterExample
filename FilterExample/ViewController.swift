//
//  ViewController.swift
//  FilterExample
//
//  Created by Patrick Bellot on 5/29/18.
//  Copyright © 2018 Polestar Interactive LLC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override var prefersStatusBarHidden: Bool { return true }
	
	var currentImage: UIImage!
	var currentFilter: CIFilter!
	let context = CIContext(options: nil)
	var arrayOfSounds = ["babyChick", "bee", "bikeHorn", "birdTweet", "cleaningGlass", "cowMoo", "cricket", "ducks", "dwarfGoat", "henLays", "kittenMew", "plasticWhistle", "squeakerToy"]
	var audioPlayer: AVAudioPlayer?
	
	let currentImageView: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "miles.jpg")
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	let filterButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Add Filter", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
		button.addTarget(self, action: #selector(changeFilter), for: .touchUpInside)
		return button
	}()
	
	let soundButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Play Sound", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
		button.tintColor = UIColor.white
		button.addTarget(self, action: #selector(playSound), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		currentImage = currentImageView.image
		setupUI()
	}
	
	fileprivate func setupUI() {
		view.add(currentImageView)
		currentImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
	
		view.add(filterButton)
		filterButton.anchor(top: nil, left: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20
			, paddingRight: 0, width: 0, height: 0)
		filterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		
		view.add(soundButton)
		soundButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
		soundButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
	}
	
	func setupAudioPlayer(_ file: String, type: String) {
		let path = Bundle.main.path(forResource: file, ofType: type)
		let url = URL.init(fileURLWithPath: path!)
		do {
			try audioPlayer = AVAudioPlayer(contentsOf: url)
		} catch {
			print("Player not available")
		}
	}
	
	@objc func playSound() {
		let range: UInt32 = UInt32(arrayOfSounds.count)
		let number = Int(arc4random_uniform(range))
		
		self.setupAudioPlayer(arrayOfSounds[number], type: "mp3")
		self.audioPlayer?.play()
	}
	
	@objc func changeFilter() {
		let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "No Filter", style: .default, handler: removeFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectChrome", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectFade", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectInstant", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectMono", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectNoir", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectProcess", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectTonal", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPhotoEffectTransfer", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIComicEffect", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIDepthOfField", style: .default, handler: setFilter))
		present(ac, animated: true, completion: nil)
	}
	
	func applyProcessing() {
		let inputKeys = currentFilter.inputKeys

		if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)}

		if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
			let processedImage = UIImage(cgImage: cgimg, scale: (currentImageView.image?.scale)!, orientation: (currentImageView.image?.imageOrientation)!) // This line adusts the imageview orientation.
			self.currentImageView.image = processedImage
		}
	}
	
	func setFilter(action: UIAlertAction) {
		guard currentImage != nil else { return }
		currentFilter = CIFilter(name: action.title!)
		let beginImage = CIImage(image: currentImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		applyProcessing()
	}
	
	func removeFilter(action: UIAlertAction) {
		guard currentImage != nil else { return }
		currentFilter = CIFilter(name: action.title!)
		if let image = currentImage {
			self.currentImageView.image = image
		}
	}
} // end of class

















