//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class ViewController: UIViewController {

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private lazy var dataSource = createDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        collectionView.dataSource = dataSource
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadData()
    }
}

extension ViewController {

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: createSection(sectionIndex:layoutEnvironment:))
    }

    func createSection(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(90),
            heightDimension: .estimated(44)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(90 / layoutEnvironment.container.effectiveContentSize.width),
            heightDimension: .estimated(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16.0
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

    func createDataSource() -> UICollectionViewDiffableDataSource<Shelf, Album> {
        let registration = createCellRegistration()
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
                cell.layer.borderColor = UIColor.red.cgColor
                cell.layer.borderWidth = 1.0
                return cell
            }
        )
    }

    func createCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Album> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Album> { (cell, indexPath, album) in
            var content = UIListContentConfiguration.subtitleCell()
            content.text = album.title
            content.secondaryText = album.description
            cell.contentConfiguration = content
        }
    }

    func loadData() {
        let shelves = [easyListeningShelf, jazzShelf, rockShelf, popShelf, danceMusicShelf, gospelShelf, metalShelf]
        var snapshot = NSDiffableDataSourceSnapshot<Shelf, Album>()
        snapshot.appendSections(shelves)
        shelves.forEach { shelf in
            snapshot.appendItems(shelf.albums, toSection: shelf)
        }
        dataSource.apply(snapshot)
    }
}

let viewController = ViewController()

viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = viewController
