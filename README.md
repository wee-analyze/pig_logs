# pig_logs
A simple example of using Pig in Hadoop to manipulate log data for ETL

Programming language: Pig

Pig is a sql-like language that runs on Hadoop for Big Data to run MapReduce jobs. It is designed for ETL pipelines
and batch processing.

The data used for this example is a small log sample and is semi-structured. Even if the sample was very large, terabytes, 
Hadoop would be able to handle the processing with MapReduce. 
This script will perform the following:
-filter out all url's that contain "linqtosql"
-retrieve only days with more than 80 visits
-sort the number of visits and then by date if visits are equal

To run this script, make a directory in HDFS called "/data" and load log data sample 2018_jan.txt.

Either load script onto harddisk of server that your logged into and execute the script or just copy and paste code into terminal.

Results will be saved in a HDFS directory called "data/results".
