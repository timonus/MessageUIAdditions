// MessageUI + TJAdditions
// Automatically implementing all the default delegate callbacks so you don't have to
// By Tim Johnsen

#import "MessageUI + TJAdditions.h"

#define FEEDBACK_RECIPIENT [NSString stringWithFormat:@"%@@%@.com", @"tijoinc", @"gmail"]		// make this the email you'd like to receive feedback at

#pragma mark - MFMailComposeViewController

@implementation MFMailComposeViewController (TJAdditions)

#pragma mark Class Methods

+ (void)presentInViewController:(UIViewController *)viewController
                    withSubject:(NSString *)subject
                    messageBody:(NSString *)messageBody
                         isHTML:(BOOL)isHTML
{
    [self presentInViewController:viewController
                 withToRecipients:nil
                          subject:subject
                      messageBody:messageBody
                           isHTML:isHTML];
}

+ (void)presentInViewController:(UIViewController *)viewController
               withToRecipients:(NSArray *)recipients
                        subject:(NSString *)subject
                    messageBody:(NSString *)messageBody
                         isHTML:(BOOL)isHTML
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [MFMailComposeViewController new];

        [controller setSubject:subject];
        [controller setMessageBody:messageBody isHTML:isHTML];
        [controller setMailComposeDelegate:controller];
        [controller setToRecipients:recipients];

        [viewController presentViewController:controller animated:YES completion:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set up Mail"
                                                                                 message:@"You haven't set up the Mail app on your device."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Go to Mail" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *urlString = @"mailto:";
            if (recipients.count == 1) {
                urlString = [urlString stringByAppendingString:recipients.firstObject];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        }]];
        if (recipients.count == 1) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"Copy email address" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIPasteboard generalPasteboard] setString:recipients.firstObject];
            }]];
        }
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleCancel handler:nil]];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}

+ (void)presentFeedbackEmailViewControllerInViewController:(UIViewController *)viewController
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *deviceModel = [[UIDevice currentDevice] model];
    NSString *deviceOSVersion = [[UIDevice currentDevice] systemVersion];
    
    [MFMailComposeViewController presentInViewController:viewController withToRecipients:[NSArray arrayWithObject:FEEDBACK_RECIPIENT] subject:[NSString stringWithFormat:@"%@ Feedback", appName] messageBody:[NSString stringWithFormat:@"<br><p><font color = \"gray\" size = 2><i>%@ %@ on %@ running iOS %@</i></font></p>", appName, appVersion, deviceModel, deviceOSVersion] isHTML:YES];
}

#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end

#pragma mark - MFMessageComposeViewController

@implementation MFMessageComposeViewController (TJAdditions)

#pragma mark Class Methods

+ (void)presentInViewController:(UIViewController *)viewController withBody:(NSString *)body
{
    MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
    
    [controller setBody:body];
    [controller setMessageComposeDelegate:controller];
    
    [controller setMessageComposeDelegate:controller];
    
    [viewController presentViewController:controller animated:YES completion:nil];
}

#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
