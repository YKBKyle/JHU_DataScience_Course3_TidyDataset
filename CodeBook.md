## Meanings of all variables in the tidy dataset 
   (tidy dataset stored in TidyDataset.txt)

There are 563 columns and 180 rows in the tidy dataset. And there are 30 subjects in this experiment. Each subject performed 6 activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING).

The first 2 columns of the tidy dataset are Id and label:
	Id: the identification of the subjects
	    specified by an integer, ranged from 1 to 30

	label: activities perfromed by the subjects
	    It is one of the 6 strings below:
	    WALKING
	    WALKING_UPSTAIRS
	    WALKING_DOWNSTAIRS
	    SITTING
	    STANDING
	    LAYING
	
From the 3rd column to the 563rd column are the average of each feature for each combination of Id and label. And the features are in the same order as in file features.txt in the original folder - UCI HAR Dataset. For example, the 3rd column: Mean.tBodyAcc.mean...X, is the average of feature tBodyAcc-mean()-X for each combination of Id and label, and tBodyAcc-mean()-X is listed in the first place in the file features.txt. This holds true for other columns in the tidy dataset.
