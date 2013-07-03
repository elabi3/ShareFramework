//
//  Created by elabi3.
//

#import <Foundation/Foundation.h>

@interface ShareOpen : NSObject

+(ShareOpen *) getInstance;

-(void) openSafariURLFromString:(NSString *) string;
-(void) openChromeURLFromString:(NSString *) string;
-(void) openOperaMiniURLFromString:(NSString *) string;

-(void) openSearchChromeFromString:(NSString *) string;

-(void) openPhoneNumberFromString:(NSString *) string;
-(void) openMessage;

-(BOOL) existChrome;

@end
