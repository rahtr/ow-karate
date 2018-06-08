package com.karate.openwhisk.resiliency;

import com.intuit.karate.cucumber.CucumberRunner;
import com.intuit.karate.cucumber.KarateStats;
import com.intuit.karate.junit4.Karate;

import cucumber.api.CucumberOptions;

import static org.junit.Assert.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * @author Rahul Tripathi
 *
 * 
 */

@RunWith(Karate.class)
@CucumberOptions(tags = {"~@ignore","~@driver","~@rlt","~@wskfunctions"})
public class ResiliencyTestRunner {
    @Test
	public void resiliencyTests(){
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
	
