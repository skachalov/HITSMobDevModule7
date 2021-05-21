

#import <UIKit/UIKit.h>

@interface OCVWrapper : NSObject;

// Get verison number
+(NSString *) versionNumber;

// Convert to grayscale
+(UIImage *) convertToGrayscale: (UIImage *) image;

+(UIImage *) classifyImage: (UIImage *) image;

@end
