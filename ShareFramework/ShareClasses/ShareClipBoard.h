//
//  Created by elabi3.
//

#import <Foundation/Foundation.h>

@interface ShareClipBoard : NSObject

+(ShareClipBoard *) getInstance;
-(void) copyStringToClipBoard:(NSString *) string;

@end
