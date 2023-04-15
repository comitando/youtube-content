import UIKit

class PhotosScrollView: UIView {
    
    // MARK: - Private Properties
    private lazy var scrollView = SimpleScrollView(spacing: 8, axis: .horizontal)
    
    private lazy var pageControl: UIPageControl = {
        let element = UIPageControl(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = false
        element.numberOfPages = quantityPhotos
        element.currentPage = 0
        element.currentPageIndicatorTintColor = Asset.Colors.spaceBlue1.color
        element.pageIndicatorTintColor = Asset.Colors.techGreen5.color
        return element
    }()
    
    private let pageController = ScrollPageController()
    private var quantityPhotos = 0
    
    // MARK: - Inits

    init(photos: [String], lateralPadding: CGFloat, spaceBetweenPhotos: CGFloat) {
        super.init(frame: .zero)
        quantityPhotos = photos.count
        setupView()
        createImageViews(photos: photos,
                         lateralPadding: lateralPadding,
                         spaceBetweenPhotos: spaceBetweenPhotos)
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Private Methods

    private func createImageViews(photos: [String],
                                  lateralPadding: CGFloat,
                                  spaceBetweenPhotos: CGFloat) {
        let size = UIScreen.main.bounds.width - lateralPadding - spaceBetweenPhotos
        
        photos.forEach { url in
            let imageView = UIImageView()
            imageView.downloaded(from: url, contentMode: .scaleAspectFill)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: size),
                imageView.heightAnchor.constraint(equalToConstant: size)
            ])
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true

            scrollView.addSubview(imageView)
        }
    }
}

extension PhotosScrollView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(scrollView)
        addSubview(pageControl)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        scrollView.delegate = self
        
    }
}

extension PhotosScrollView: UIScrollViewDelegate {
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
