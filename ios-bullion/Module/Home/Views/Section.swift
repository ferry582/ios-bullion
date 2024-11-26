//
//  Section.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func configureHeader(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
    func configureFooter(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
}

extension Section {
    func configureHeader(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func configureFooter(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}

struct CarouselSection: Section {
    let numberOfItems = 3
    var onPageChange: ((Int) -> Void)?
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.45))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(12))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        footer.contentInsets = .init(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 24, leading: 12, bottom: 0, trailing: 12)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems.append(footer)
        section.visibleItemsInvalidationHandler = { _, offset, environment in
            let pageWidth = environment.container.contentSize.width
            let currentPage = Int((offset.x / pageWidth).rounded())
            self.onPageChange?(currentPage)
        }
        
        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CarouselItemCollectionViewCell.self), for: indexPath) as! CarouselItemCollectionViewCell
        cell.configure(with: UIImage(named: "Banner")!)
        return cell
    }
    
    func configureFooter(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PageIndicatorCollectionReusableView.identifier, for: indexPath) as! PageIndicatorCollectionReusableView
        footerView.configure(totalPages: numberOfItems)
        return footerView
    }
}

struct ListUsersSection: Section {
    var users: [User]
    var numberOfItems: Int {
        return users.count
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        header.contentInsets = .init(top: 58, leading: 0, bottom: 0, trailing: 0)
        
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        backgroundItem.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems.append(header)
        section.contentInsets = .init(top: 84, leading: 24, bottom: 127, trailing: 24)
        section.decorationItems = [backgroundItem]

        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCollectionViewCell.self), for: indexPath) as! UserCollectionViewCell
        cell.configure(user: users[indexPath.item])
        return cell
    }
    
    func configureHeader(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSectionCollectionReusableView.identifier, for: indexPath) as! TitleSectionCollectionReusableView
        footerView.configure(title: "List Users")
        return footerView
    }
}
