// MessageUI + TJAdditions
// Automatically implementing all the default delegate callbacks so you don't have to
// By Tim Johnsen

#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MFMailComposeViewController

@interface MFMailComposeViewController (TJAdditions) <MFMailComposeViewControllerDelegate>

+ (void)presentInViewController:(UIViewController *)viewController
                    withSubject:(NSString *)subject
                    messageBody:(NSString *)messageBody
                         isHTML:(BOOL)isHTML;
+ (void)presentInViewController:(UIViewController *)viewController
               withToRecipients:(nullable NSArray *)recipients
                        subject:(NSString *)subject
                    messageBody:(NSString *)messageBody
                         isHTML:(BOOL)isHTML;

+ (void)presentFeedbackEmailViewControllerInViewController:(UIViewController *)viewController;

@end

#pragma mark - MFMessageComposeViewController

@interface MFMessageComposeViewController (TJAdditions) <MFMessageComposeViewControllerDelegate>

+ (void)presentInViewController:(UIViewController *)viewController withBody:(NSString *)body;

@end

NS_ASSUME_NONNULL_END
