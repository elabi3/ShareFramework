//
//  Created by elabi3.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ShareEmail : NSObject <MFMailComposeViewControllerDelegate> {
    UIViewController *viewControllerClass;
}

@property (strong, nonatomic) MFMailComposeViewController *mailComposer;

+(ShareEmail *) getInstance;
-(void) emailText:(NSString *) stringText  asunto:(NSString *) asunto  destinatarios:(NSArray *) destinatarios urlString:(NSString *) stringURL viewController:(UIViewController *) viewController;

@end
