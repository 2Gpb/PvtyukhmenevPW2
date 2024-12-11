//
//  CustomSlider.swift
//  HomeWork2
//
//  Created by Peter on 20.11.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum View {
            static let backgroundColor: UIColor = .white
        }
        
        enum TitleView {
            static let fontSize: CGFloat = 17
            static let fontWeight: UIFont.Weight = .bold
            static let top: Double = 10
            static let leading: Double = 20
        }
        
        enum CurrentValue {
            static let text: String = "0%"
            static let fontSize: CGFloat = 17
            static let fontWeight: UIFont.Weight = .bold
            static let top: Double = 10
            static let leading: Double = 10
        }
        
        enum Slider {
            static let event: UIControl.Event = .valueChanged
            static let startValue: Float = 0
            static let leading: Double = 20
            static let bottom: Double = 10
        }
    }
    
    // MARK: - Variables
    var valueChanged: (() -> ())?
    
    // MARK: - Private fields
    private let titleView = UILabel()
    
    // MARK: - Fields
    let slider = UISlider()
    let currentValue = UILabel()
    
    //MARK: - Lifecycle
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.maximumValue = Float(max)
        slider.minimumValue = Float(min)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = Constants.View.backgroundColor
        setUpTitleView()
        setUpCurrentValue()
        setUpSlider()
    }
    
    private func setUpTitleView() {
        titleView.font =
            .systemFont(
                ofSize: Constants.TitleView.fontSize,
                weight: Constants.TitleView.fontWeight
            )
        
        addSubview(titleView)
        titleView.pinTop(to: topAnchor, Constants.TitleView.top)
        titleView.pinLeft(to: leadingAnchor, Constants.TitleView.leading)
    }
    
    private func setUpCurrentValue() {
        currentValue.text = Constants.CurrentValue.text
        currentValue.font = .systemFont(
            ofSize: Constants.CurrentValue.fontSize,
            weight: Constants.CurrentValue.fontWeight
        )
        
        addSubview(currentValue)
        currentValue.pinTop(to: topAnchor, Constants.CurrentValue.top)
        currentValue.pinLeft(to: titleView.trailingAnchor, Constants.CurrentValue.leading)
    }
    
    private func setUpSlider() {
        slider.value = Constants.Slider.startValue
        slider.addTarget(self, action: #selector(sliderValueChanged), for: Constants.Slider.event)
        
        addSubview(slider)
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinLeft(to: leadingAnchor, Constants.Slider.leading)
        slider.pinCenterX(to: centerXAnchor)
        slider.pinBottom(to: bottomAnchor, Constants.Slider.bottom)
    }
    
    // MARK: - Actions
    @objc
    private func sliderValueChanged() {
        valueChanged?()
    }
}