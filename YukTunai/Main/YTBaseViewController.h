
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTBaseViewController : UIViewController

@property (nonatomic, strong) UIView *cBar;
@property (nonatomic, strong) UIView *cBarBG;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UIButton *backB;
@property (nonatomic, strong) UIImageView *topBgImgView;

- (void)setNavigationBarTitle:(NSString *)title;
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)bTapped;
- (void)setBarBgHidden;
- (void)setbgImgViewHidden;
- (void)setbgTopImgViewShow;

@end

NS_ASSUME_NONNULL_END
