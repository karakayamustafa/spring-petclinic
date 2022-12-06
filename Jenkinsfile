pipeline {
  agent {
      node {
          label 'docker-slave'
      }
  }
  stages {
    
    stage('Cloning our Git') {
      steps {
        checkout scm

        def customImage = docker.build("my-image:${env.BUILD_ID}")

        customImage.inside {
           sh 'make test'
        }
      }
    }
    
}


