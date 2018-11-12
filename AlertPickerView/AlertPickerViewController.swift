//
//  AlertPickerViewController.swift
//  AlertPickerView
//
//  Created by 松山 友也 on 2018/11/12.
//  Copyright © 2018年 松山 友也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AlertPickerViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var backRoundedView: UIView! {
        didSet {
            backRoundedView.layer.cornerRadius = Const.cornarRadius
        }
    }

    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var holizonalLineView: UIView!
    @IBOutlet private weak var verticalLineView: UIView!

    private var model: Model!

    var tappedLeftButton: Observable<Void> {
        return leftButton.rx.tap.asObservable()
    }

    var tapeedRightButton: Observable<Void> {
        return rightButton.rx.tap.asObservable()
    }

    var selected: Observable<SelectedItem> {
        return selectedRelay.asObservable()
    }

    private let selectedRelay = PublishRelay<SelectedItem>()

    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = .custom

        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

extension AlertPickerViewController {

    private enum Const {
        static let cornarRadius: CGFloat = 12
    }

    struct Model {
        let columns: [Colum]

        struct Colum {
            let rows: [Row]

            struct Row {
                let title: String?
            }
        }
    }

    struct SelectedItem {
        let component: Int
        let row: Int

        init(_ component: Int, _ row: Int) {
            self.component = component
            self.row = row
        }
    }

    static func instantiate(with model: Model) -> AlertPickerViewController? {
        let storyBoard = UIStoryboard(name: String(describing: AlertPickerViewController.self), bundle: Bundle(for: AlertPickerViewController.self))

        guard let viewController = storyBoard.instantiateInitialViewController() as? AlertPickerViewController else { return nil }

        viewController.model = model

        return viewController
    }
}

extension AlertPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return model.columns.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.columns[component].rows.count
    }

    func pickerView(_ pickerview: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
        return model.columns[component].rows[row].title
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRelay.accept(.init(component, row))
    }

}
