package com.karate.openwhisk.utils;
import com.intuit.karate.FileUtils;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
public class OWFileUtil {
    private static final Logger logger = LoggerFactory.getLogger(OWFileUtil.class);

    public static String writeToFile(String jsonMsg, String fileName) {
        File parentDir = FileUtils.getDirContaining(OWFileUtil.class);
        //String parentDir = System.getProperty("user.dir") + "/src/test/java/com/karate/openwhisk/utils";
        System.out.println("Parent dir path: "+parentDir);
        File file = new File(parentDir, fileName);
        FileWriter writer = null;
        BufferedWriter bufferedWriter = null;
        try {
            writer = new FileWriter(file);
            bufferedWriter = new BufferedWriter(writer);
            bufferedWriter.write(jsonMsg);
        } catch (IOException e) {
            logger.error("Error saving {} to file {}", jsonMsg, fileName, e);
            throw new RuntimeException(e);
        } finally {
            if (bufferedWriter != null) {
                try {
                    bufferedWriter.close();
                } catch (IOException e) {
                }
            }
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                }
            }
        }
        logger.info("Successfully saved {} content: {}", fileName, jsonMsg);
        return "success";
    }


}
