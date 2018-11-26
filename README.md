## Analysis Steps

This repo contains 3 files: README.md, CodeBook.md and run_analysis.R

README.md:      explain the analysis steps in run_analysis.R
CodeBook.md:    explain the variables in the tidy dataset
run_analysis.R: the R file to perform the analysis

All the analysis steps are contains in the file run_analysis.R

Steps are as below:
	
	Step 0: load library dplyr and reshape2
		set up paths of the files to be loaded
		define a function to read files without headers and keep strings as character
		load features.txt as Features11
		load activity_labels.txt as ActivityLabel
		load x_train.txt, y_train.txt, subject_train.txt into a list: TrainData
		load x_test.txt, y_test.txt, subject_test.txt into a list: TestData

	Step 1: Form a data frame IdXY_train (IdXY_test):
			1st column: Id of the subject
			last column: activity performed by the subject
			other column: dataset in x_train.txt (x_test.txt)
		combine IdXY_train and IdXY_test into one dataset IdXY_All:
			Rows of IdXY_test follow those of IdXY_train

	Step 2: Get IdXY_All's columns whose names contain "mean" or "std"

	Step 3: re-assign the value of column label
		original value 1 will be re-assigned as "WALKING"
		original value 2 will be re-assigned as "WALKING_UPSTAIRS"
		original value 3 will be re-assigned as "WALKING_DOWNSTAIRS"
		original value 4 will be re-assigned as "SITTING"
		original value 5 will be re-assigned as "STANDING"
		original value 6 will be re-assigned as "LAYING"

	Step 4: convert Features$V2 to syntatically valid
		and assign an order to dupliated feature names
		re-assign the column names of MeanStd as Feature$V2

	Step 5: covert MeanStd from wide data to long data: MeanStd2
		using function melt, set id.vars=c("Id","label")

		covert MeanStd2 back from long data to wide data
		and calculate mean on every column for each combination of Id and label

	Step 6: output tidy data set MeanStd2 to file TidyDataset.txt
		without rownames of MeanStd2
