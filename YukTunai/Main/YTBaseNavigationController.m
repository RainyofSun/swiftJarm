

#import "YTBaseNavigationController.h"

@implementation YTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setNavigationBarHidden:true];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    navigationController.interactivePopGestureRecognizer.delegate = (navigationController.viewControllers.count > 1) ? self : nil;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1;
}


- (void)bcTapped {
    self.vcDelegate == nil ?  [self popViewControllerAnimated:YES] : [self.vcDelegate bca];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Frame12323"] style:UIBarButtonItemStylePlain target:self action:@selector(bcTapped)];
    }
    [super pushViewController:viewController animated:animated];
}

@end
