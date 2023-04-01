package com.easydataservices.open.db2compress;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.zip.GZIPOutputStream;
import java.util.zip.GZIPInputStream;
import sqlj.runtime.ref.DefaultContext;

/**
 * Class for DB2 GZip compression.
 *
 * @author jeremy.rickard@easydataservices.com
 */

public class Gzip {
  final private static int BUFSIZE = 1048576;
  final private static int GZIPBUFSIZE = 65536;

  /**
   * Compress a BLOB using Java gzip compression.
   * @param blob Uncompressed BLOB. 
   * @return Compressed BLOB.
   */
  public static Blob compressBlob(Blob blob) throws SQLException {
    Blob compressedBlob;

    // Return null for null input.
    if (blob == null) {
      return null;
    }

    // Obtain connection, and create result Blob.
    try {
      DefaultContext context = DefaultContext.getDefaultContext();
      compressedBlob = context.getConnection().createBlob();  
    }
    catch (Exception exception) {
      throw new SQLException("Failed to create Blob from default context connection: " + exception.getMessage());
    }
    
    // Compress.
    byte[] bytes = new byte[BUFSIZE];
    try (GZIPOutputStream gzipOutputStream = new GZIPOutputStream(compressedBlob.setBinaryStream(1), GZIPBUFSIZE)) {
      int index = 0;
      while (index < blob.length()) {
        int length = BUFSIZE;
        if (blob.length() - index < BUFSIZE) {
          length = (int) blob.length() - index;
        }
        bytes = blob.getBytes(index + 1, length);
        gzipOutputStream.write(bytes, 0, length);
        index = index + length;
      }
      gzipOutputStream.finish();
    }
    catch (IOException exception) {
      throw new SQLException(exception.getMessage());
    }
    return compressedBlob;
  }

  /**
   * Uncompress a BLOB that was compressed using Java gzip compression.
   * @param compressedBlob Compressed BLOB. 
   * @return Uncompressed BLOB.
   */
  public static Blob uncompressBlob(Blob compressedBlob) throws SQLException {
    Blob blob;

    // Return null for null input.
    if (compressedBlob == null) {
      return null;
    }

    // Obtain connection, and create result Blob.
    try {
      DefaultContext context = DefaultContext.getDefaultContext();
      blob = context.getConnection().createBlob();  
    }
    catch (Exception exception) {
      throw new SQLException("Failed to create Blob from default context connection: " + exception.getMessage());
    }

    // Uncompress.
    byte[] bytes = new byte[BUFSIZE];
    try (GZIPInputStream gzipInputStream = new GZIPInputStream(compressedBlob.getBinaryStream(), GZIPBUFSIZE)) {
      int index = 0;
      int length = 1;
      while (length > 0) {
        length = gzipInputStream.read(bytes, 0, BUFSIZE);
        if (length > 0) {
          blob.setBytes(index + 1, bytes, 0, length);
          index = index + length;
        }
      }
    }
    catch (IOException exception) {
      throw new SQLException(exception.getMessage());
    }
    return blob;
  }
}
