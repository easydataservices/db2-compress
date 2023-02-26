# db2-compress
Experimental Db2 UDFs for compressing and uncompressing BLOBs

## Synopsis
LOBs can consume a lot of space. Db2 Adpative Compression can compress inline LOBs, but unfortunately there is no in-built feature for compressing larger LOBs. This project repository experiements with UDFs that use Java Gzip compressiion to do just that. BLOBs are the initial target.

## Status
Initial testing (Db2 for LUW 11.5.8) suggests that the code is working as intended. However, a number of checks need to be made before it could be considered for production use.

See also the comments in [Early preview of db2-compress](https://github.com/easydataservices/db2-compress/discussions/2).

## Important considerations
> Note: The code appears to work, yet some IBM doucmentation says it should not. I have opened an IBM case open to determine whether or not this code is supported.

Even if the code is valid, consider that:
1. It might be better to compress data in the application instead, to distribute the cost across a number of servers.
    * Then again, in many IT departments developers are unconcerned about administration issues, and at best classify compression as a nice-to-have for possible future implementation (i.e. probably never). A transparent method of compressing, that they do not need to worry about is therefore attractive.
1. The solution is likely to slow insert and retrieval of data. Its best use case would be an archive database for older that can be written once, and seldom retrieved.

## Quick installation instructions
1. Compile the functions using the Ant XML build file.
1. Connect to your Db2 for LUW database.
1. Enter the Db2 CLP shell: ``db2 -t``
1. Change to the db2 directory contains files install_jar.sql and functions.sql.
1. Install the JAR:
    1. Copy line 2 of install_jar.sql. Edit the file URL in the first parameter to match the location of the JAR file built by the first step (must be full path).
    1. Execute the amended SQL, e.g.: ``CALL sqlj.install_jar('file:/home/jsmith/myjars/db2-compress.jar', 'UTILS.GZIPJAR');``
1. Change to the reate the functions: db2 -tf functions.sql

The functions should now be usable, e.g. ``VALUES utils.gzip_compress(CAST('test' as BLOB));``

Note that gzip compression can result in bigger output than input when the input data length is small or is data that will not compress well.
