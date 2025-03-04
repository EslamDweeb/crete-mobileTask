//
//  ModelGenerationVC.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 03/03/2025.
//

import UIKit

class ModelGenerationVC: BaseWireFrame<ModelGenerationsViewModel> {
    @IBOutlet weak var compareBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var brandLogoImage: UIImageView!
    @IBOutlet weak var vechilesTableView: UITableView!
    lazy var  headerview:TableHeaderView = {
        let headerView = TableHeaderView()
        return headerView
    }()
    private var floatingCompareView: FloatingCompareView!
    private var overlayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brandLogoImage.kf.setImage(with: URL(string: viewModel.brandImageURL))
        viewModel.viewDidload()
        setupHeaderView()
        setupTableView()
        setupFloatingCompareView()
        setupOverlayView()
    }
    private func setupHeaderView(){
        headerview.configuer(imageURL: viewModel.modelImageURL, modelName: viewModel.modelName, modelYear: viewModel.modelYear)
        vechilesTableView.tableHeaderView = headerview
        headerview.frame.size.height = headerview.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    private func setupTableView() {
        vechilesTableView.registerCellNib(cellClass: VehicleCell.self)
        // Enable dynamic cell height
        vechilesTableView.rowHeight = UITableView.automaticDimension
        vechilesTableView.estimatedRowHeight = 100
        // Handle table view item selection
        viewModel.vechiles.bind(to: vechilesTableView.rx.items(cellIdentifier: VehicleCell.getIdentifier(),cellType: VehicleCell.self)){ index, vechiles, cell in
            //cell.configure(with: brand)
           
            cell.configure(with: vechiles)
        }
        .disposed(by: disposeBag)
        vechilesTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print("Selected item at \(indexPath)")
            })
            .disposed(by: disposeBag)
    }
    override func bind(viewModel: ModelGenerationsViewModel) {
        viewModel.isLoading.subscribe {[weak self] loading in
            guard let self else{return}
            guard let isLoading = loading.element else{return}
            if isLoading{
                DispatchQueue.main.async {
                    self.showIndicator(withTitle: "", and: "")
                }
            }else{
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
            }
        }.disposed(by: disposeBag)
        
        viewModel.hasErrInTxt.subscribe {[weak self] msg in
            guard let self,let msg = msg.element else{return}
            if msg != "" {
                DispatchQueue.main.async {
                    self.createAlert(title: "Error",erroMessage: msg)
                }
            }
        }.disposed(by: disposeBag)
        backBtnAction()
        compareBtnAction()
    }
    private func backBtnAction(){
        backBtn.rx.tap.subscribe {[weak self] tap in
            guard let self else{return}
            self.PopToOldPage()
        }.disposed(by: disposeBag)
    }
    private func compareBtnAction(){
        compareBtn.rx.tap.subscribe {[weak self] tap in
            guard let self else{return}
            let compareCount = 3 // Replace with actual count
            self.floatingCompareView.updateCompareCount(compareCount)

            // Show the floating view
            self.showFloatingCompareView()
        }.disposed(by: disposeBag)
       
    }
}
extension ModelGenerationVC {
    fileprivate func setupFloatingCompareView() {
          floatingCompareView = FloatingCompareView()
          floatingCompareView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(floatingCompareView)

          // Position the floating view at the bottom of the screen
          NSLayoutConstraint.activate([
              floatingCompareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              floatingCompareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
              floatingCompareView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
              floatingCompareView.heightAnchor.constraint(equalToConstant: 50)
          ])

          // Initially hide the floating view
          floatingCompareView.alpha = 0
          floatingCompareView.transform = CGAffineTransform(translationX: 0, y: 100)
      }

      private func setupOverlayView() {
          overlayView = UIView()
          overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3) // Semi-transparent black
          overlayView.alpha = 0 // Initially hidden
          overlayView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(overlayView)

          // Cover the entire screen
          NSLayoutConstraint.activate([
              overlayView.topAnchor.constraint(equalTo: view.topAnchor),
              overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])

          // Add a tap gesture recognizer to the overlay
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOverlayTap))
          overlayView.addGestureRecognizer(tapGesture)
      }

      @objc private func handleOverlayTap() {
          hideFloatingCompareView()
      }

      func showFloatingCompareView() {
          // Show the overlay
          UIView.animate(withDuration: 0.3) {
              self.overlayView.alpha = 1
          }

          // Show the floating view
          UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
              self.floatingCompareView.alpha = 1
              self.floatingCompareView.transform = .identity
          }, completion: nil)
      }

      func hideFloatingCompareView() {
          // Hide the overlay
          UIView.animate(withDuration: 0.3, animations: {
              self.overlayView.alpha = 0
          })

          // Hide the floating view
          UIView.animate(withDuration: 0.3, animations: {
              self.floatingCompareView.alpha = 0
              self.floatingCompareView.transform = CGAffineTransform(translationX: 0, y: 100)
          }, completion: { _ in
              // Optionally remove the floating view from the view hierarchy
              self.floatingCompareView.removeFromSuperview()
          })
      }
}
