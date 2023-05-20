import UIKit

class PhotosCollectionView: UIView {
    
    // MARK: - Private Properties
    private lazy var layout: UICollectionViewFlowLayout = {
        let size = UIScreen.main.bounds.width - lateralPadding - spaceBetweenPhotos
        let element = UICollectionViewFlowLayout()
        element.itemSize = .init(width: size, height: size)
        element.estimatedItemSize = .init(width: size, height: size)
        element.minimumLineSpacing = spaceBetweenPhotos
        element.scrollDirection = .horizontal

        return element
    }()
    
    private lazy var collectionView: UICollectionView = {
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.delegate = self
        element.dataSource = self
        element.isPagingEnabled = true
        element.showsHorizontalScrollIndicator = false
        element.clipsToBounds = false
        return element
    }()
    
    private lazy var pageControl: UIPageControl = {
        let element = UIPageControl(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = false
        element.numberOfPages = photos.count
        element.currentPage = 0
        element.currentPageIndicatorTintColor = Asset.Colors.spaceBlue1.color
        element.pageIndicatorTintColor = Asset.Colors.techGreen5.color
        return element
    }()
    
    private let pageController = ScrollPageController()
    private let photos: [String]
    private let lateralPadding: CGFloat
    private let spaceBetweenPhotos: CGFloat
    
    // MARK: - Inits

    init(photos: [String], lateralPadding: CGFloat, spaceBetweenPhotos: CGFloat) {
        self.photos = photos
        self.lateralPadding = lateralPadding
        self.spaceBetweenPhotos = spaceBetweenPhotos
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }    
}

extension PhotosCollectionView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(collectionView)
        addSubview(pageControl)
    }
    
    func setupConstraints() {
        let pageControlHeight: CGFloat = 30
        let collectionViewHeight = layout.itemSize.height + pageControlHeight

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: pageControlHeight),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension PhotosCollectionView: UICollectionViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let pageOffset = pageController.pageOffset(for: scrollView.contentOffset.x,
                                                         velocity: velocity.x,
                                                         in: pageOffsets(in: scrollView)) else {
            return
        }
            
        targetContentOffset.pointee.x = pageOffset
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let pageFraction = pageController.pageFraction(for: scrollView.contentOffset.x,
                                                             in: pageOffsets(in: scrollView)) else {
            return
        }
        
        pageControl.currentPage = Int(round(pageFraction))
    }

    private func pageOffsets(in scrollView: UIScrollView) -> [CGFloat] {
        let adjustedContentInset = scrollView.adjustedContentInset
        let pageWidth = scrollView.bounds.width - adjustedContentInset.left - adjustedContentInset.right
        let numberOfPages = Int(ceil(scrollView.contentSize.width / pageWidth))
        return (0..<numberOfPages).map { CGFloat($0) * pageWidth - adjustedContentInset.left }
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return .init()
        }
        
        cell.updatePhoto(photoUrl: photos[indexPath.row])
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension PhotosCollectionView: UIScrollViewDelegate {
    
}
