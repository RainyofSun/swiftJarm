

#import <UIKit/UIKit.h>


@protocol YTNavigationDelegate <NSObject>
- (void)bca;
@end



@interface YTBaseNavigationController : UINavigationController <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<YTNavigationDelegate> vcDelegate;

@end

