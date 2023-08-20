//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class ViewController: UIViewController {

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    fileprivate let shelves = [easyListeningShelf, jazzShelf, rockShelf, popShelf, danceMusicShelf, gospelShelf, metalShelf]
    private lazy var dataSource = createDataSource()
    private lazy var registration = createCellRegistration()

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
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16.0
        return section
    }

    func createDataSource() -> UICollectionViewDiffableDataSource<Int, Shelf> {
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [registration] (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
                return cell
            }
        )
    }

    func createCellRegistration() -> UICollectionView.CellRegistration<MyCell, Shelf> {
        // Specifying MyCell and Shelf here are redundant but keeping it here so as to
        // not refactor the example too much just to illustrate the proposed
        // solution to the problem.
        return UICollectionView.CellRegistration<MyCell, Shelf> { (cell, indexPath, shelf) in
            let flowLayout = UICollectionViewFlowLayout()
                flowLayout.scrollDirection = .horizontal
                flowLayout.estimatedItemSize = CGSize(width: 90, height: 44) // Wouldn't it have made more sense to use .automatic?
                cell.nestedCollectionView.collectionViewLayout = flowLayout
                cell.nestedCollectionView.dataSource = self
                cell.nestedCollectionView.delegate = self
                cell.nestedCollectionView.reloadData()
        }
    }

    func loadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Shelf>()
        snapshot.appendSections((0..<shelves.count).enumerated().map { $0.offset })
        shelves.enumerated().forEach { indexAndShelf in
            let index = indexAndShelf.offset
            let shelf = indexAndShelf.element
            snapshot.appendItems([shelf], toSection: index)
        }
        dataSource.apply(snapshot)
    }
}

// MARK: - <UICollectionViewDataSource> for inner cell -

extension ViewController: UICollectionViewDelegateFlowLayout {

}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shelves.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: String(describing: AlbumCell.self))
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumCell.self), for: indexPath) as! AlbumCell
        let shelf = shelves[indexPath.section]
        let album = shelf.albums[indexPath.item]
        cell.titleLabel.text = album.title
        return cell
    }
}

// MARK: - Inner cell definition -

// A Cell with a UICollectionView and Flow Layout (Stackoverflow proposed approach).
class MyCell: UICollectionViewCell {
    static let identifier = "MyCell"

    let nestedCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(nestedCollectionView)

        NSLayoutConstraint.activate([
            nestedCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nestedCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nestedCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nestedCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// A cell with an album title.
class AlbumCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(titleLabel)
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        // Add constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}


let viewController = ViewController()

viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = viewController
