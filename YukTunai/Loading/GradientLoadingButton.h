//
//  GradientLoadingButton.h
//  YukTunai
//
//  Created by 一刻 on 2025/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientLoadingButton : UIControl

@property (nonatomic, strong) UILabel *titleLabel;

/// 设置标题
- (void)setTitle:(NSString *)title;

/// 设置渐变色（至少 2 个 UIColor）
- (void)setGradientColors:(NSArray<UIColor *> *)colors;

/// 设置圆角
@property (nonatomic, assign) CGFloat cornerRadius;

/// 停止 loading（对外暴露）
- (void)stopLoading;
- (void)startLoading;

@end

NS_ASSUME_NONNULL_END
