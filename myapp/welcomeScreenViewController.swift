//
//  ViewController.swift
//  myapp
//
//  Created by erhan demirci on 23.02.2022.
//

import UIKit
import Lottie
extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5 * self.frame.size.width)) /
        self.frame.width) + 1
    }
}
class welcomeScreenViewController: UIViewController, UIScrollViewDelegate {
    override func viewDidAppear(_ animated: Bool) {
        //scheduledTimerWithTimeInterval()
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    private var animationView: AnimationView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollContainer: UIView!
    var numberOfPages=5
    var timer:Timer!
    
    private var welcomeBtn:UIButton={
        let welcomeBtn=UIButton()
        welcomeBtn.backgroundColor = .white
        welcomeBtn.setTitle("BAŞLA", for: .normal)
        welcomeBtn.setTitleColor(.brown, for: .normal)
        welcomeBtn.translatesAutoresizingMaskIntoConstraints=false
        welcomeBtn.addTarget(self, action: #selector(baslaClicked), for: .touchUpInside)
        return welcomeBtn
    }()
    
    @objc func animateScrollView() {
            let scrollWidth = scrollView.bounds.width
            let currentXOffset = scrollView.contentOffset.x

            let lastXPos = currentXOffset + scrollWidth
            if lastXPos != scrollView.contentSize.width {
                print("Scroll")
                pageControl.currentPage=scrollView.currentPage
                scrollView.setContentOffset(CGPoint(x: lastXPos, y: 0), animated: true)
            }
            else {
                print("Scroll to start")
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                pageControl.currentPage=0

            }
        }

    func scheduledTimerWithTimeInterval(){
            // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.animateScrollView), userInfo: nil, repeats: true)
        }
    
    @objc func baslaClicked()
    {
        print("başla çalıştı")
        let storyboard = UIStoryboard(name: "AppStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "firstViewController")
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        
     
        

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = scrollView.currentPage-1
        print(scrollView.currentPage-1)
    }
    override func viewWillLayoutSubviews() {
        scrollView.contentSize.width=self.scrollView.frame.size.width * 5
    }
    func checkAge() {
        
      var age: Int? = 22

      guard let myAge = age else {
        print("Age is undefined")
        return
      }

      print("My age is \(myAge)")
        
        var name: String? = "erhan"
        /*
        guard name != nil else
        {
            return
        }
        */
        guard let name=name else {
            return
        }
        print("name \(name)")
    }

    
    override func viewDidLoad() {
        checkAge()
        pageControl.numberOfPages=numberOfPages
        pageControl.currentPage = 0
        scrollView.delegate = self
        
        //self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 5,height: self.scrollView.frame.size.height)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        animationView = .init(name: "coffee")
        animationView!.translatesAutoresizingMaskIntoConstraints=false
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.9
        scrollContainer.addSubview(animationView!)
        animationView!.play()
        
        scrollContainer.sendSubviewToBack(animationView!)
        
        self.view.addSubview(welcomeBtn)
        
        NSLayoutConstraint.activate([animationView.topAnchor.constraint(equalTo: scrollContainer.topAnchor,constant: 10),animationView.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor, constant: -150),animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),animationView.widthAnchor.constraint(equalTo: scrollContainer.widthAnchor, multiplier: 1/5)])
        var widthOfContent=self.scrollView.frame.size.width * 4
        NSLayoutConstraint.activate([welcomeBtn.bottomAnchor.constraint(equalTo: scrollContainer.topAnchor,constant: 5),welcomeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 0),welcomeBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),welcomeBtn.heightAnchor.constraint(equalToConstant: 40),scrollContainer.widthAnchor.constraint(equalToConstant:widthOfContent )])

        
    }


}

