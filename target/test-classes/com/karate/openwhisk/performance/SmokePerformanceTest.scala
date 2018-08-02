package com.karate.openwhisk.performance

import io.gatling.core.Predef._
import com.intuit.karate.gatling.PreDef._
import scala.concurrent.duration._

class BasicSimulation extends Simulation {

    val smokeTestTriggers = scenario("triggers").exec(karateFeature("classpath:com/karate/openwhisk/triggerbasictests/trigger-basic-tests.feature"))
    //val smokeTest = scenario("smoke").exec(karateFeature("classpath:com/karate/openwhisk/basictestcases/WskBasicTest.feature"))
    val smokeTestBasicTests = scenario("basic").exec(karateFeature("classpath:com/karate/openwhisk/basictestcases/WskBasicTest.feature"))
    val smokeTest = scenario("smoke").exec(smokeTestTriggers).exec(smokeTestBasicTests)

  setUp(
    smokeTest.inject(constantUsersPerSec(10) during (5 seconds))
    ).assertions(global.responseTime.mean.lt(35))
}
