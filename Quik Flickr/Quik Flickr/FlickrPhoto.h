#import <Foundation/Foundation.h>

@class FlickrPhotoItemMedia;

@interface FlickrPhoto : NSObject <NSCoding> {

}

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *dateTaken;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) FlickrPhotoItemMedia *media;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIImage *image;

+ (FlickrPhoto *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionary;

- (NSURL *)publicURL;

@end
