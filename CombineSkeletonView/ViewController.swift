//
//  ViewController.swift
//  CombineSkeletonView
//
//  Created by 新垣 清奈 on 2022/09/21.
//

import UIKit
import Combine
import SkeletonView
import SDWebImage

enum ViewState {
    case loading
    case content(value: Any?)
    case error
}

protocol ViewStatable where Self: UIViewController {
    var stateSubject: PassthroughSubject<ViewState, Never> { get }
}

class ViewController: UIViewController , ViewStatable {

    var stateSubject: PassthroughSubject<ViewState, Never> = .init()
    private let apiShouldSucceed: Bool = true
    private var anyCancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        observe()
        fetchUserProfile()
    }

    private func observe() {
        stateSubject
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                guard let self = self else { return }
                self.view.removeAllSubViews()
                switch state {
                case .loading:
                    let loadingView = UserProfileLoadingView()
                    loadingView.pinToParent(parent:self.view)
                    loadingView.startAnimating()

                case .content(value: let value):
                    let contentView = UserProfileContentView()
                    guard let user = value as? User else { fatalError() }
                    contentView.configure(user: user)
                    contentView.pinToParent(parent: self.view)
                case .error:
                    break
                }
        }
        .store(in: &anyCancellable)
    }

    private func fetchUserProfile(){
        stateSubject.send(.loading)

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [unowned self] in
            if apiShouldSucceed {
                stateSubject.send(.content(value: User.mock))
            } else {
                stateSubject.send(.error)
            }
        }
    }

}
