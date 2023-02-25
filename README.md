 # db2-compress
Experimental Db2 UDFs for compressing and uncompressing BLOBs

## Synopsis
LOBs can consume a lot of space. Db2 Adpative Compression can compress inline LOBs, but unfortunately there is no in-built feature for compressing larger LOBs. This project repository experiements with UDFs that use Java Gzip compressiion to do just that. BLOBs are the initial target.

## Status
Initial testing suggests that the code is working as intended. However, a number of checks need to be made before it could be considered for production use.

See also the comments in [Early preview of db2-compress](https://github.com/easydataservices/db2-compress/discussions/2).

## Important considerations
Even if the code is valid, consider that:
1. It might be better to compress data in the application instead, to distribute the cost across a number of servers.
    * Then again, in many IT departments developers are unconcerned about administration issues, and at best classify compression as a nice-to-have for possible future implementation (i.e. probably never). A transparent method of compressing, that they do not need to worry about is therefore attractive.
1. The solution is likely to slow insert and retrieval of data. Its best use case would be an archive database for older that can be written once, and seldom retrieved.
