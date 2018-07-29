package com.karate.openwhisk.performance

import com.karate.openwhisk.wskadmin._
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import com.intuit.karate.FileUtils
import java.io.File
import java.nio.file.{Files, Paths}


import com.intuit.karate.FileUtils
import com.karate.openwhisk.utils.OWFileUtil
//import io.gatling.http.Predef._

import scala.concurrent.duration._

class LoadTestOnCreateAction extends Simulation {
  before{
    println("Simulation is about to start!")
    val ar = new WskAdminRunner()
    ar.WskAdminRunner()
  }
  val createActionTest = scenario("create").exec(karateFeature("classpath:com/karate/openwhisk/smoketests/TC05_SmokeTest_getuser.feature"))


  setUp(createActionTest.inject(rampUsers(5) over (5 seconds))
    ).maxDuration(1 minutes).assertions(global.responseTime.mean.lt(65))

  after {
    println("Deleting authFile.txt")
    val path : File = FileUtils.getDirContaining(classOf[OWFileUtil])
    println(Files.deleteIfExists(Paths.get(path+"/authFile.txt")))
    println("Simulation is finished!")
  }
}
