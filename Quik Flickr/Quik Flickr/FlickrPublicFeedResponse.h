#import <Foundation/Foundation.h>

@interface FlickrPublicFeedResponse : NSObject <NSCoding> {

}

@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *generator;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *modified;
@property (nonatomic, strong) NSString *title;

+ (FlickrPublicFeedResponse *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionary;

@end
