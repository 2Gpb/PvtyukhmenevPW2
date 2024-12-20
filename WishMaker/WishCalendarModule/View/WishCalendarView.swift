//
//  WishCalendarView.swift
//  HomeWork2
//
//  Created by Peter on 03.12.2024.
//
import UIKit

protocol WishCalendarViewDelegate: AnyObject {
    func goBackScreen()
}

final class WishCalendarView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum View {
            static let backgroundColor: UIColor = .background
        }
        
        enum CollectionView {
            static let backgroundColor: UIColor = .clear
            static let sectionInsets: UIEdgeInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0
            )
            static let top: CGFloat = 15
            static let heightCell: CGFloat = 165
            static let totalIndent: CGFloat = 20
            static let lineSpacing: CGFloat = 15
        }
        
        enum BackButton {
            static let image: UIImage = UIImage(systemName: "chevron.left") ?? UIImage()
            static let color: UIColor = .white
            static let state: UIControl.State = .normal
            static let event: UIControl.Event = .touchUpInside
            static let top: CGFloat = 0
            static let leading: CGFloat = 10
            static let height: CGFloat = 24
            static let width: CGFloat = 24
        }
    }
    
    // MARK: - Variables
    weak var delegate: WishCalendarViewDelegate?
    
    // MARK: - Privavte variables
    private var events: [WishEvent] = [WishEvent(
        title: "I want to finish the layout in Figma. ",
        description: "I want to finish the layout in figma of an application I'm going to write for my diploma.",
        startDate: "11:00, 12.09.2024",
        endDate: "13:00, 12.09.2024"
    )]
    
    //MARK: - Private fields
    private let backButton: UIButton = UIButton(type: .system)
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - SetUp
    func setUp() {
        backgroundColor = Constants.View.backgroundColor
        setUpBackButton()
        setUpCollectionView()
    }
    
    private func setUpBackButton() {
        backButton.setImage(Constants.BackButton.image, for: Constants.BackButton.state)
        backButton.tintColor = Constants.BackButton.color
        backButton.addTarget(self, action: #selector(goBackScreen), for: Constants.BackButton.event)

        addSubview(backButton)
        backButton.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.BackButton.top)
        backButton.pinLeft(to: safeAreaLayoutGuide.leadingAnchor, Constants.BackButton.leading)
        backButton.setHeight(Constants.BackButton.height)
        backButton.setWidth(Constants.BackButton.width)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Constants.CollectionView.backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseId)
        
        addSubview(collectionView)
        collectionView.pinTop(to: backButton.bottomAnchor, Constants.CollectionView.top)
        collectionView.pinBottom(to: bottomAnchor)
        collectionView.pinHorizontal(to: self)
    }
    
    // MARK: - Actions
    @objc
    private func goBackScreen() {
        delegate?.goBackScreen()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width - Constants.CollectionView.totalIndent,
            height: Constants.CollectionView.heightCell
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print((indexPath.item))
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.CollectionView.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return Constants.CollectionView.sectionInsets
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return events.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WishEventCell.reuseId,
            for: indexPath
        ) as? WishEventCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: events[indexPath.row])
        
        return cell
    }
}
