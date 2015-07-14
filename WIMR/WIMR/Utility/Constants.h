//
//  Constants.h
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#ifndef WIMR_Constants_h
#define WIMR_Constants_h

#define kWIMRResourceUrl @"http://whoismyrepresentative.com/"
#define kAllMember @"getall_mems.php?"

#define kRepByName @"getall_reps_byname.php?"
#define kRepByState @"getall_reps_bystate.php?"

#define kSenByName @"getall_sens_byname.php?"
#define kSenByState @"getall_sens_bystate.php?"

#define kParmName @"name"
#define kParmState @"state"
#define kParmZip @"zip"
#define kJSONErrorResponseKey @"results"

typedef void (^JSONResultBlock)(id JSON);
typedef void (^ErrorResultBlock)(NSError *error);

#endif
