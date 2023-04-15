import UIKit

class PhotosView: UIView {
    
    // MARK: - Private Properties
    private lazy var scrollView = SimpleScrollView(spacing: 8, axis: .horizontal)
    
    private lazy var pageControl: UIPageControl = {
        let element = UIPageControl(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
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
        let width = UIScreen.main.bounds.width - lateralPadding - spaceBetweenPhotos
        
        photos.forEach { url in
            let imageView = UIImageView()
            imageView.downloaded(from: url, contentMode: .scaleAspectFill)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: width),
                imageView.heightAnchor.constraint(equalToConstant: width)
            ])
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true

            scrollView.addSubview(imageView)
        }
    }
}

extension PhotosView: ViewCodable {
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
        
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = quantityPhotos
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Asset.Colors.spaceBlue1.color
        pageControl.pageIndicatorTintColor = Asset.Colors.techGreen5.color
    }
}

// Extension de exemplo de uso de download direto na UIImageView
// https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension PhotosView: UIScrollViewDelegate {
    // to make pagination working, implement this delegate function:

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

    // if you have a page control you would like to update when scrolling:

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let pageFraction = ScrollPageController().pageFraction(for: scrollView.contentOffset.x,
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
