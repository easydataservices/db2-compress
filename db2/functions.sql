CREATE OR REPLACE FUNCTION utils.gzip_compress(p_blob BLOB(2M)) RETURNS BLOB(2M)
  LANGUAGE JAVA
  PARAMETER STYLE JAVA 
  FENCED
  EXTERNAL NAME 'UTILS.GZIPJAR:com.easydataservices.open.db2compress.Gzip.compressBlob';

CREATE OR REPLACE FUNCTION utils.gzip_uncompress(p_compressed_blob BLOB(2M)) RETURNS BLOB(2M)
  LANGUAGE JAVA
  PARAMETER STYLE JAVA 
  FENCED
  EXTERNAL NAME 'UTILS.GZIPJAR:com.easydataservices.open.db2compress.Gzip.uncompressBlob';
 
 -- DROP FUNCTION utils.gzip_compress;
 -- DROP FUNCTION utils.gzip_uncompress;
 
