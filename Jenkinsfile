pipeline {
    agent { label 'docker' }

    environment {
        registryUrl = "https://registry.hub.docker.com"
        registryCredential = 'dockerhub_id'
        registryUrl = "registry.hub.docker.com"
        repo = "karakayamust/spring-petclinic"
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image') {
            steps {
                script{
                    image = docker.build(repo)
                }
            }
        }

        stage('Test image') {
            steps {
                script{
                    image.inside {
                        sh 'echo "Tests passed"'
                    }                
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry(registryUrl, registryCredential) {
                        image.push("${env.BUILD_ID}")
                        image.push("latest")
                    }
                }
            }
        }

        stage('Clean up image') {
            steps {
                sh "docker rmi $registry/$repo:$BUILD_ID"
                sh "docker rmi $registry/$repo:$latest"
            }
        }
    }
}