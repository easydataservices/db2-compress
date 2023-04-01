-- Install JAR.
CALL sqlj.install_jar('file:/home/eds/Projects/git/db2-compress/java/dist/db2-compress.jar', 'UTILS.GZIPJAR');

-- Update JAR and tell Db2 to refresh classes.
CALL sqlj.replace_jar('file:/home/eds/Projects/git/db2-compress/java/dist/db2-compress.jar', 'UTILS.GZIPJAR');
CALL sqlj.refresh_classes();

-- Remove JAR (you must drop functions first).
CALL sqlj.remove_jar('UTILS.GZIPJAR');
