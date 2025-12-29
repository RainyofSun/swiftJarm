

#import "YTScrollView.h"

@implementation YTScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            if ([self respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        
        self.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    return self;
}


@end
