//
//  UIAlertController+DY.h
//  ChessGame
//
//  Created by dai yi on 2017/8/16.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^UIAlertActionHandler)(UIAlertAction *action);
@interface UIAlertController (DY)

/**
 创建一个alertController

 @param message 展示的消息内容
 @param leftHandler  左边点击的回调
 @param rightHandler 右边按钮点击的回调
 @param leftTitle    左边按钮的title
 @param rightTitle   右边按钮的title
 @param leftStyle    左边按钮的样式
 @param rightStyle   右边按钮的样式
 @param title        整个alert的标题
 @return UIAlertController弹框对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                        leftHandler:(UIAlertActionHandler)leftHandler
                       rightHandler:(UIAlertActionHandler)rightHandler
                          leftTitle:(NSString *)leftTitle
                         rightTitle:(NSString *)rightTitle
                          leftStyle:(UIAlertActionStyle)leftStyle
                         rightStyle:(UIAlertActionStyle)rightStyle
                              title:(NSString *)title;

/**
 创建一个左右两边按钮默认样式的alertController

 @param message 展示的消息内容
 @param leftHandler  左边点击的回调
 @param rightHandler 右边按钮点击的回调
 @param leftTitle    左边按钮的title
 @param rightTitle   右边按钮的title
 @param title        整个alert的标题
 @return UIAlertController弹框对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                        leftHandler:(UIAlertActionHandler)leftHandler
                       rightHandler:(UIAlertActionHandler)rightHandler
                          leftTitle:(NSString *)leftTitle
                         rightTitle:(NSString *)rightTitle
                              title:(NSString *)title;

/**
 创建一个左右两边按钮默认样式，没有标题 的alertController
 
 @param message 展示的消息内容
 @param leftHandler  左边点击的回调
 @param rightHandler 右边按钮点击的回调
 @param leftTitle    左边按钮的title
 @param rightTitle   右边按钮的title
 @return UIAlertController弹框对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                        leftHandler:(UIAlertActionHandler)leftHandler
                       rightHandler:(UIAlertActionHandler)rightHandler
                          leftTitle:(NSString *)leftTitle
                         rightTitle:(NSString *)rightTitle;

/**
 创建一个右边按钮默认样式，左边按钮的样式可选，没有标题 的alertController
 
 @param message 展示的消息内容
 @param leftHandler  左边点击的回调
 @param rightHandler 右边按钮点击的回调
 @param leftTitle    左边按钮的title
 @param rightTitle   右边按钮的title
 @param leftStyle    左边按钮的样式
 @return UIAlertController弹框对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                        leftHandler:(UIAlertActionHandler)leftHandler
                       rightHandler:(UIAlertActionHandler)rightHandler
                          leftTitle:(NSString *)leftTitle
                         rightTitle:(NSString *)rightTitle
                          leftStyle:(UIAlertActionStyle)leftStyle;


/**
 创建 确认 ，取消（取消样式可选）, 不带有标题 的alertController

 @param message 展示的消息内容
 @param okHandler     确定按钮点击的回调
 @param cancelHandler 取消按钮点击的回调
 @param cancelStyle   取消按钮的样式
 @return alertController对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                          okHandler:(UIAlertActionHandler)okHandler
                      cancelHandler:(UIAlertActionHandler)cancelHandler
                        cancelStyle:(UIAlertActionStyle)cancelStyle;

/**
 创建 确认 ，取消（取消样式为Destructive）, 不带有标题 的alertController

 @param message 展示的消息内容
 @param okHandler     确定按钮点击的回调
 @param cancelHandler 取消按钮点击的回调
 @return alertController对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                          okHandler:(UIAlertActionHandler)okHandler
                      cancelHandler:(UIAlertActionHandler)cancelHandler;

/**
 创建 确认 ，取消（取消样式为Destructive）, 带有标题 的alertController
 
 @param message 展示的消息内容
 @param okHandler     确定按钮点击的回调
 @param cancelHandler 取消按钮点击的回调
 @param title         标题
 @return alertController对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                          okHandler:(UIAlertActionHandler)okHandler
                      cancelHandler:(UIAlertActionHandler)cancelHandler
                              title:(NSString *)title;




/**
 只有一个按钮 的alertController

 @param message 展示的消息内容
 @param singleHandler 按钮点击的回调
 @param singleTitle   按钮的标题
 @param singleStyle   按钮的样式
 @param title         alertTitle
 @return alertController对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message singleHandler:(UIAlertActionHandler)singleHandler  singleTitle:(NSString *)singleTitle singleStyle:(UIAlertActionStyle)singleStyle title:(NSString *)title;

/**
 只有一个按钮 的alertController

 @param message 展示的消息内容
 @param singleHandler 按钮点击的回调
 @param singleTitle   按钮的标题
 @param singleStyle   按钮的样式
 @return alertController对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                      singleHandler:(UIAlertActionHandler)singleHandler
                        singleTitle:(NSString *)singleTitle
                        singleStyle:(UIAlertActionStyle)singleStyle;

/**
 只有 确定 按钮的alertController

 @param message 展示的消息内容
 @param okHandler 确定按钮的点击回调
 @return alertController对象
 */
+ (UIAlertController *)alertMessage:(NSString *)message
                          okHandler:(UIAlertActionHandler)okHandler;

- (void)setAttributeMessage:(NSAttributedString *)attributeMessage;
- (void)setAttributeTitle:(NSAttributedString *)attributeTitle;
- (void)setAttributeMessage:(NSAttributedString *)attributeMessage attributeTitle:(NSAttributedString *)attributeTitle;
- (void)setFirstActionColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor;

/**
 验证是否支持key(KVC)

 @param keypath key
 @param cls     类
 @return 是否支持
 */
+ (BOOL)validateKeypath:(NSString *)keypath forClass:(Class)cls;


/**
 创建一个alertSheet

 @param title   title
 @param titiles 点击的title
 @param handler 点击的回调
 @return alertController对象
 */
+ (UIAlertController *)alertSheetWithTitle:(NSString *)title titles:(NSArray<NSString *> *)titiles  handler:(void(^)(NSInteger index))handler;

@end
