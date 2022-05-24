// See README.md for license details.

//ThisBuild / scalaVersion     := "2.13.8"
ThisBuild / scalaVersion     := "2.12.13"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "%ORGANIZATION%"

val chiselVersion = "3.5.1"

lazy val root = (project in file("."))
  .settings(
    name := "%NAME%",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % chiselVersion,
      "edu.berkeley.cs" %% "chiseltest" % "0.5.1" % "test",
      "io.github.chiselverify" % "chiselverify" % "0.2.0",
      "org.jacop" % "jacop" % "4.7.0",
      "org.jliszka" %% "probability-monad" % "1.0.3"        
    ),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit",
      "-P:chiselplugin:genBundleElements",
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % chiselVersion cross CrossVersion.full),
  )

