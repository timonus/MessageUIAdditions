// MessageUI + TJAdditions
// Automatically implementing all the default delegate callbacks so you don't have to
// By Tim Johnsen

#import <MessageUI/MessageUI.h>

#pragma mark -
#pragma mark MFMailComposeViewController

@interface MFMailComposeViewController (TJAdditions) <MFMailComposeViewControllerDelegate>

+ (void)presentInViewController:(UIViewController *)viewController withSubject:(NSString *)subject messageBody:(NSString *)messageBody isHTML:(BOOL)isHTML;
+ (void)presentInViewController:(UIViewController *)viewController withToRecipients:(NSArray *)recipients subject:(NSString *)subject messageBody:(NSString *)messageBody isHTML:(BOOL)isHTML;

@end

#pragma mark -
#pragma mark MFMessageComposeViewController

@interface MFMessageComposeViewController (TJAdditions) <MFMessageComposeViewControllerDelegate>

+ (void)presentInViewController:(UIViewController *)viewController withBody:(NSString *)body;

@end