/**
 * 
 */
package com.karate.openwhisk.smoketests;
import com.intuit.karate.cucumber.CucumberRunner;
import com.intuit.karate.cucumber.KarateStats;
import com.intuit.karate.junit4.Karate;

import cucumber.api.CucumberOptions;
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

import static org.junit.Assert.*;	

/**
 * @author Rahul Tripathi
 *
 * 
 */
@RunWith(Karate.class)
@CucumberOptions(tags = {"~@ignore","~@driver","~@reliability","~@resiliency","~@concurrent","~@wskfunctions"})
public class SmokeTestRunner {
	
	  
	  
}



