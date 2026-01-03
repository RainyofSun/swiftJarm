

#import "YTBaseViewController.h"

@interface YTBaseViewController ()

@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation YTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCustomNavigationBar];
    
    self.backB.hidden = self.navigationController.viewControllers.count == 1 ? YES : NO;
    self.bgImgView.frame = self.view.bounds;
    self.topBgImgView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width * 0.89);
    
    self.topBgImgView.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:3/255.0 green:52/255.0 blue:114/255.0 alpha:1];
    
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.topBgImgView];
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    self.cBar.alpha = hidden ? 0 : 1;
    self.cBarBG.hidden = hidden;
}


- (void)setupCustomNavigationBar {
   
    self.cBar = [[UIView alloc] init];
    self.cBarBG = [[UIView alloc] init];
    

    self.cBar.backgroundColor = [UIColor clearColor];
    
    self.cBarBG.backgroundColor = [UIColor clearColor];
    

    [self.view addSubview:self.cBarBG];
    [self.view addSubview:self.cBar];
    

    self.cBarBG.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.cBarBG.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.cBarBG.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.cBarBG.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.cBarBG.heightAnchor constraintEqualToConstant:44 + [self statusBarH]]
    ]];

    self.cBar.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.cBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.cBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.cBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.cBar.heightAnchor constraintEqualToConstant:44]
    ]];
    

    self.tLabel = [[UILabel alloc] init];
    self.tLabel.font = [UIFont boldSystemFontOfSize:20];
    self.tLabel.textAlignment = NSTextAlignmentCenter;
    self.tLabel.textColor = [UIColor whiteColor];
    [self.cBar addSubview:self.tLabel];
    
    self.tLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tLabel.centerXAnchor constraintEqualToAnchor:self.cBar.centerXAnchor],
        [self.tLabel.centerYAnchor constraintEqualToAnchor:self.cBar.centerYAnchor]
    ]];
    

    self.backB = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backB setImage:[UIImage imageNamed:@"sett_arr"] forState:UIControlStateNormal];
    self.backB.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    [self.backB addTarget:self action:@selector(bTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.backB.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backB.layer.shadowOpacity = 0.06;
    self.backB.layer.shadowOffset = CGSizeZero;
    
    [self.cBar addSubview:self.backB];
    
    self.backB.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.backB.leadingAnchor constraintEqualToAnchor:self.cBar.leadingAnchor constant:16],
        [self.backB.centerYAnchor constraintEqualToAnchor:self.cBar.centerYAnchor constant:0]
    ]];
}


- (CGFloat)statusBarH {
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    return window.windowScene.statusBarManager.statusBarFrame.size.height;
}

- (void)bTapped {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setBarBgHidden {
    self.cBar.backgroundColor = [UIColor clearColor];
    
    self.cBarBG.backgroundColor = [UIColor clearColor];
}

- (void)setbgImgViewHidden {
    self.bgImgView.hidden = YES;
}

- (void)setbgTopImgViewShow {
    self.topBgImgView.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.cBarBG];
    [self.view bringSubviewToFront:self.cBar];
}


- (void)setNavigationBarTitle:(NSString *)title {
    self.tLabel.text = title;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImgView;
}

- (UIImageView *)topBgImgView {
    if (!_topBgImgView) {
        _topBgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"auth_top"]];
        _topBgImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return  _topBgImgView;
}

@end
