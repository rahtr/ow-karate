package com.karate.openwhisk.performance

import io.gatling.core.Predef._
import com.intuit.karate.gatling.PreDef._
import com.intuit.karate.FileUtils
import java.io.File
import com.karate.openwhisk.utils.OWFileUtil
import com.karate.openwhisk.wskadmin.WskAdminRunner
import java.nio.file.{Files, Paths}
import io.gatling.http.Predef._

import scala.concurrent.duration._

class SmokePerformanceTest extends Simulation {

  before{
    println("Simulation is about to start!")
    val ar = new WskAdminRunner()
    ar.WskAdminRunner()
  }
  val smokeTest = scenario("smoke").exec(karateFeature("classpath:com/karate/openwhisk/wskadmin/get-user.feature"))
  //val smokeTest = scenario("smoke").exec(request)

  //val smokeTest = scenario("smoke").exec(getUser)
  setUp(
    smokeTest.inject(rampUsers(1) over (10 seconds))).maxDuration(1 minutes)
  //).assertions(global.responseTime.mean.lt(35))
  after {
    println("Deleting authFile.txt")
    val path : File = FileUtils.getDirContaining(classOf[OWFileUtil])
    println(Files.deleteIfExists(Paths.get(path+"/authFile.txt")))
    println("Simulation is finished!")
  }
}