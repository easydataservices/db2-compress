CREATE OR REPLACE FUNCTION utils.gzip_compress(p_blob BLOB(20M)) RETURNS BLOB(20M)
  LANGUAGE JAVA
  PARAMETER STYLE JAVA 
  FENCED
  RETURNS NULL ON NULL INPUT
  EXTERNAL NAME 'UTILS.GZIPJAR:com.easydataservices.open.db2compress.Gzip.compressBlob';

CREATE OR REPLACE FUNCTION utils.gzip_uncompress(p_compressed_blob BLOB(20M)) RETURNS BLOB(20M)
  LANGUAGE JAVA
  PARAMETER STYLE JAVA 
  FENCED
  RETURNS NULL ON NULL INPUT
  EXTERNAL NAME 'UTILS.GZIPJAR:com.easydataservices.open.db2compress.Gzip.uncompressBlob';

CREATE OR REPLACE FUNCTION utils.blob_crc32(p_blob BLOB(20M)) RETURNS BIGINT
  LANGUAGE JAVA
  PARAMETER STYLE JAVA 
  FENCED
  RETURNS NULL ON NULL INPUT
  EXTERNAL NAME 'UTILS.GZIPJAR:com.easydataservices.open.db2compress.Gzip.blobCRC32';

CREATE OR REPLACE FUNCTION utils.gzip_compressed_blob_crc32(p_compressed_blob BLOB(20M)) RETURNS BIGINT
  LANGUAGE JAVA
  PARAMETER STYLE JAVA 
  FENCED
  RETURNS NULL ON NULL INPUT
  EXTERNAL NAME 'UTILS.GZIPJAR:com.easydataservices.open.db2compress.Gzip.compressedBlobCRC32';

 -- DROP FUNCTION utils.gzip_compress;
 -- DROP FUNCTION utils.gzip_uncompress;
 -- DROP FUNCTION utils.blob_crc32;
 -- DROP FUNCTION utils.gzip_compressed_blob_crc32;
 
