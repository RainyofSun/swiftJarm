
#import "YTTableView.h"

@implementation YTTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        if (@available(iOS 11.0, *)) {
            if ([self respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                self.estimatedSectionFooterHeight = 0;
                self.estimatedSectionHeaderHeight = 0;
                self.scrollIndicatorInsets = self.contentInset;
            }
        }
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.sectionHeaderHeight = 0.0;
        self.sectionFooterHeight = 0.0;
        

        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 150000
        if (@available(iOS 15.0, *)) {
            self.sectionHeaderTopPadding = 0;
        }
        #endif
    }
    return self;
}


@end
