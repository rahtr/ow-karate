/**
 * 
 */
package com.karate.openwhisk.reliability;
import com.intuit.karate.cucumber.CucumberRunner;
import com.intuit.karate.cucumber.KarateStats;
import com.intuit.karate.junit4.Karate;

import cucumber.api.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * @author Rahul Tripathi
 *
 * 
 */
@RunWith(Karate.class)
@CucumberOptions(tags = {"~@ignore","~@driver","~@reliability","~@resiliency","~@concurrent"})
public class WskFunctionsTestRunner {
	  @Test
	    public void testwskFunctions() {
		    String karateOutputPath = "target/surefire-reports";
	        KarateStats stats = CucumberRunner.parallel(getClass(), 5, karateOutputPath);
	        generateReport(karateOutputPath);
	        assertTrue("there are scenario failures", stats.getFailCount() == 0);        
	    }
	    private static void generateReport(String karateOutputPath) {
	        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
	        List<String> jsonPaths = new ArrayList(jsonFiles.size());
	        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
	        Configuration config = new Configuration(new File("target"), "openwhisk");
	        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
	        reportBuilder.generateReports();        
	    }
	    }
	  
	  

