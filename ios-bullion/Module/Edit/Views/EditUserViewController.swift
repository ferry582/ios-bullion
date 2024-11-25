//
//  EditUserViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

class EditUserViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: EditUserViewModel
    
    // MARK: - Life Cyle
    init(viewModel: EditUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
