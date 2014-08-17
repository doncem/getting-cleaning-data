### Code/Cook book

This is a tutorial (step by step) through the course project, explaining how each goal is accomplished

* Script should deal with the data automatically so user can just run it and get the results
** It is easy to allow script to take extra parameter to allow dynamic URL for data to be downloaded, but in this case we pressume we just want assignment to be done
** It is important to check whether we have unpacked files. I only checked the relevant folder to be existant. Don't mind the contents of it
* After short investigation figure out which data files need to be loaded to complete the mission. And they are as follows:
** test/X_test.txt
** test/y_test.txt
** train/X_train.txt
** train/y_train.txt
** activity_labels.txt
** features.txt
* Before applying column names, joining the data sets together, better prepare its' contents by joining activities to each of them:
** merge is in use
* Set the column names
** Note! Features only sets all but one columns. Alter the last one manually
** P.S. There is probably a one-liner for that, but didn't waste my time and applied one column manually to continue coding
* Find out which columns you need to extract to first batch of results
** grep pattern used
** for loop used - :(. Could not find more suitable function other than rbind, which did not look right to me
* Finally - write data to txt file producing the first results
* Produce another file which displays the mean of each of those values grouped by activity column
** I used already filtered features data
