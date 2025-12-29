
#import "YTBaseCollectionView.h"

@implementation YTBaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = YES;
        self.pagingEnabled = NO;
        self.alwaysBounceVertical = YES;
        self.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        if (@available(iOS 11.0, *)) {
            if ([self respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
    return self;
}


@end
