//
//  WeatherViewController.swift
//  Weatherate
//
//  Created by Grigor Aghabalyan on 7/12/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var tadayLabel: UILabel!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    
    @IBOutlet weak var nextDaysLabel: UILabel!
    @IBOutlet weak var nextDaysCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBt: UIBarButtonItem!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        todayCollectionView.dataSource = self
        nextDaysCollectionView.dataSource = self
        registerCell()
    }
    
    
    // MARK: - Registers
    private func registerCell() {
        let nib = UINib(nibName: WeatherCollectionViewCell.name, bundle: nil)
        todayCollectionView.register(nib, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
        nextDaysCollectionView.register(nib, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
    }
    
    // MARK: - Actions
}

// MARK: - UICollectionViewDataSource
extension WeatherViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == todayCollectionView {
            return 13
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let todayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell
        let nextDaysCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell
        
        if collectionView == todayCollectionView {
            return todayCollectionViewCell ?? UICollectionViewCell()
        } else {
            return nextDaysCollectionViewCell ?? UICollectionViewCell()
        }
    }
}
