//
//  FilterDialogView.swift
//  GithubEvents
//
//  Created by João Palma on 25/09/2020.
//

import UIKit

class FilterDialogView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    private let _backgroundView = UIView()
    private let _filterPicker = UIPickerView()
    private var _selectedEventIndex: Int!
    private var _filterEventCompletionHandler: CompletionHandlerWithParam<EventFilter>!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.tag = 0
    }

    func showFilter(_ selectedEventIndex: Int, _ event: @escaping CompletionHandlerWithParam<EventFilter>) {
        _selectedEventIndex = selectedEventIndex
        _filterEventCompletionHandler = event
        _configureView()
        _show()
    }

    private func _configureView() {
        _addBackgroundView()
        _addFilterView()
    }

    private func _addBackgroundView() {
        self.addSubview(_backgroundView)
        _backgroundView.fillSuperview()
        _backgroundView.backgroundColor = UIColor.Theme.transparentBlack

        let gesture = UITapGestureRecognizer(target: self, action: #selector(_closeView))
        _backgroundView.addGestureRecognizer(gesture)
    }

    private func _addFilterView() {
        var filterView = UIView()
        filterView.backgroundColor = UIColor.Theme.mainGrey
        self.addSubview(filterView)
        filterView.centerInSuperview()
        filterView.withHeight(255)
        filterView.layer.cornerRadius = 6
        filterView.layer.masksToBounds = true

        _addMenuAndPicker(&filterView)
    }

    private func _addMenuAndPicker(_ filterView: inout UIView) {
        let title = UILabel(text: "Filter Event", font: .boldSystemFont(ofSize: 26), textColor: UIColor.Theme.white)
        filterView.addSubview(title)
        title.anchor(top: filterView.topAnchor, leading: filterView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.allSides(13))

        let closeButton = UIButton(image: UIImage(systemName: "xmark.circle.fill")!, tintColor: UIColor.Theme.white, action: #selector(_closeView))
        closeButton.withSize(CGSize(width: 48, height: 48))
        filterView.addSubview(closeButton)
        closeButton.anchor(top: nil, leading: nil, bottom: nil, trailing: filterView.trailingAnchor)
        closeButton.centerYTo(title.centerYAnchor)

        filterView.addSubview(_filterPicker)
        _filterPicker.anchor(top: title.bottomAnchor, leading: filterView.leadingAnchor, bottom: nil, trailing: filterView.trailingAnchor)
        _filterPicker.delegate = self
        _filterPicker.dataSource = self
        _filterPicker.selectRow(_selectedEventIndex, inComponent: 0, animated: false)
    }

    private func _show() {
        Utils.keyWindow.addSubview(self)
        self.fillSuperview()
    }

    @objc private func _closeView() { _removeView() }

    private func _removeView() { self.viewWithTag(0)?.removeFromSuperview() }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { EventFilter.allCases[row].rawValue }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 40 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { EventFilter.allCases.count }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _filterEventCompletionHandler(EventFilter.allCases[row])
        _removeView()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
