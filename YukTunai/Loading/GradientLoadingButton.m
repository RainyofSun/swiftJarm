//
//  GradientLoadingButton.m
//  YukTunai
//
//  Created by 一刻 on 2025/12/29.
//

#import "GradientLoadingButton.h"

@interface GradientLoadingButton ()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

/// 是否正在 loading（拦截重复点击）
@property (nonatomic, assign) BOOL loading;

@end

@implementation GradientLoadingButton

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.loading = NO;
    self.cornerRadius = 8;

    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint   = CGPointMake(1, 0.5);
    [self.layer insertSublayer:self.gradientLayer atIndex:0];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = UIColor.whiteColor;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];

    [self setGradientColors:@[[UIColor colorWithRed:249/255.0 green:222/255.0 blue:111/255.0 alpha:1], [UIColor colorWithRed:1.0 green:136/255.0 blue:39/255.0 alpha:1]]];
    self.indicator =
    [[UIActivityIndicatorView alloc]
     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicator.hidesWhenStopped = YES;
    [self addSubview:self.indicator];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    self.gradientLayer.frame = self.bounds;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;

    self.titleLabel.frame = self.bounds;
    self.indicator.center =
    CGPointMake(CGRectGetMidX(self.bounds),
                CGRectGetMidY(self.bounds));
}

#pragma mark - Public

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setGradientColors:(NSArray<UIColor *> *)colors {
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)color.CGColor];
    }
    self.gradientLayer.colors = cgColors;
}

- (void)stopLoading {
    self.loading = NO;
    self.userInteractionEnabled = YES;

    [self.indicator stopAnimating];
    self.titleLabel.hidden = NO;
}

#pragma mark - Action

- (void)startLoading {
    if (self.loading) {
        return; // 👈 拦截重复点击
    }

    self.loading = YES;
    self.userInteractionEnabled = NO;

    self.titleLabel.hidden = YES;
    [self.indicator startAnimating];
}

@end
