# db2-compress
Db2 for LUW UDFs for compressing and uncompressing BLOBs

## Synopsis
LOBs can consume a lot of space. Db2 Adpative Compression can compress inline LOBs, but unfortunately there is no in-built feature for compressing larger LOBs. This project repository experiements with UDFs that use Java Gzip compressiion to do just that. BLOBs are the initial target.

## Status
Initial testing (Db2 for LUW 11.5.8) suggests that the code is working as intended.

IBM Case TS012225198 has confirmed that the approach is valid. Specifically, a Java UDF may now return a LOB data type (and documentation that says otherwise will be updated).

Further testing will now be performed, with a view to a release soon.

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
