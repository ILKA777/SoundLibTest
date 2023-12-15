//
//  ViewController.swift
//  SoundLibTest
//
//  Created by Илья on 30.10.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    // Выбор библиотеки TuningFork
    @IBAction func didTapTuningForkButton(_ sender: UIButton) {
        let tunerView = UIHostingController(rootView: TunerView())
        
        // Embed the SwiftUI view in a NavigationView
        let navController = UINavigationController(rootViewController: tunerView)
        
        // Present the NavigationView
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func didTapZenTunerButton(_ sender: UIButton) {
        let zenTunerView = UIHostingController(rootView: TunerScreen())
        
        // Embed the SwiftUI view in a NavigationView
        let navController = UINavigationController(rootViewController: zenTunerView)
        
        // Present the NavigationView
        present(navController, animated: true, completion: nil)
        
    }
    // Выбор библиотеки Tuna
    @IBAction func didTapTunaButton() {
        let storyboard = UIStoryboard(name: "TunaViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TunaViewController") as! TunaViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapSciTunerButton(_ sender: UIButton) {
        let tunerViewController = TunerViewController()
        
        present(tunerViewController, animated: true, completion: nil)
        
        
        
        
    }
    
    
}

