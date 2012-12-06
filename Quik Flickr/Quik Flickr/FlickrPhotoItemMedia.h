#import <Foundation/Foundation.h>

@interface FlickrPhotoItemMedia : NSObject <NSCoding> {

}

@property (nonatomic, strong) NSString *m;

+ (FlickrPhotoItemMedia *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionary;

@end
