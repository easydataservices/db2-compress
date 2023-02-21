 # db2-blob-compress
Experimental Db2 UDFs for compressing and uncompressing BLOBs

## Synopsis
LOBs can consume a lot of space. Db2 Adpative Compression can compress inline LOBs, but unfortunately there is no in-built feature for compressing larger LOBs. This project repository experiements with UDFs that use Java Gzip compressiion to do just that. BLOBs are the initial target.

## Status
Imitial testing suggests that the code is working as intended. However, a number of checks need to be made before it could be considered for production use.

According to the Db2 manuals, Java UDFs do not support input or output LOB parameters! However the documentation appears possibly inconsistent in places, and may be out of date. I intend to clarify this with IBM over the coming weeks.

## Important considerations
Even if the code is valid, consider this:
1. It might be better to compress data in the application instead, to distribute the cost across a number of servers.
1. The solution is likely to slow insert and retrieval of data. Its best use case would be an archive database for older that can be written once, and seldom retrieved.
